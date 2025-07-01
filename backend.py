import datetime
import platform
from logger import logger

from PySide6.QtCore import Qt, QObject, Signal, Slot, Property, QThread

from git_command import GitCommand
from authors_model import AuthorsModel, AuthorsOfYearMonthModel
from sortable_model import SortableModel
from recent_directories_model import RecentDirectoriesModel


class GitCommandThread(QThread):
    finished = Signal()

    def __init__(self, git_command, directory, parent=None):
        super().__init__(parent)
        self._git_command = git_command
        self._directory = directory

    def run(self):
        try:
            self._git_command.generateGitStats(self._directory)
        except Exception as e:
            logger.error(f'Error generate git stats: {e}')
        finally:
            self.finished.emit()


class Backend(QObject):
    loading = Signal(bool)
    projectChanged = Signal()
    checkGitRepo = Signal(bool)

    def __init__(self):
        super().__init__()
        self._is_loading = False
        self._git_command = GitCommand()
        self._recent_dirs_model = RecentDirectoriesModel()
        self._recent_dirs_model.loadFromFile()
        self._directory = self._recent_dirs_model.getLatestDirectory()
        self._general_data = {'name': '', 'branch': '', 'first_commit_time': '',
                              'last_commit_time': '', 'age': '', 'total_files': '',
                              'total_commits': '', 'total_authors': '', 'total_lines': '',
                              'generated': ''}
        self._git_command_thread = None
        self._authors_model = AuthorsModel()
        self.authors_model = SortableModel(self._authors_model, Qt.DescendingOrder, 3)
        self._authors_of_year_model = AuthorsOfYearMonthModel()
        self.authors_of_year_model = SortableModel(self._authors_of_year_model, Qt.DescendingOrder, 0)
        self._authors_of_month_model = AuthorsOfYearMonthModel(isYear=False)
        self.authors_of_month_model = SortableModel(self._authors_of_month_model, Qt.DescendingOrder, 0)

    @Property(QObject, constant=True)
    def recentDirsModel(self):
        return self._recent_dirs_model

    def generateGitStats(self):
        self._is_loading = True
        self.loading.emit(True)
        if self._git_command_thread:
            self._git_command_thread.quit()
            self._git_command_thread.wait()
        self._git_command_thread = GitCommandThread(self._git_command, self._directory)
        self._git_command_thread.finished.connect(self.setProject)
        self._git_command_thread.start()

    @Slot(str)
    def setDirectory(self, path: str):
        if self.isGitRepo(path):
            self._directory = path
            self._recent_dirs_model.addDirectory(path)
            self.generateGitStats()

    @Slot(str)
    def openDirectory(self, path: str):
        if platform.system() == 'Windows':
            path = path.replace('file:///', '')
        elif platform.system() == 'Linux':
            path = path.replace('file://', '')
        if self.isGitRepo(path):
            self._directory = path
            self._recent_dirs_model.addDirectory(path)
            self.generateGitStats()

    @Slot(str)
    def deleteDirectory(self, path: str):
        self._recent_dirs_model.deleteDirectory(path)

    def saveOnExit(self):
        self._recent_dirs_model.saveToFile()

    @Slot()
    def clearRecentDirectories(self):
        self._recent_dirs_model.clearDirectories()
        self._directory = ''
        self.setProject()

    @property
    def hasGit(self):
        result = self._git_command.getGitVersion()
        has_git = 'git version' in result
        self._general_data['git'] = result.split()[2] if has_git else ''
        return has_git

    def isGitRepo(self, path: str):
        result = self._git_command.isGitRepo(path)
        self.checkGitRepo.emit(result)
        return result

    def _generateData(self):
        git_version = self._general_data['git']
        self._general_data = self._git_command.getGeneralData(self._directory)
        self._general_data['git'] = git_version
        self._general_data['generated'] = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    def _generateAuthorsData(self):
        authors = self._git_command.getAuthorsData()
        self._authors_model.resetData(authors)
        authors_of_year_month = self._git_command.getAuthorsOfYearMonthData()
        self._authors_of_year_model.resetData(authors_of_year_month[0])
        self._authors_of_month_model.resetData(authors_of_year_month[1])

    def getProject(self):
        return self._general_data

    def setProject(self):
        if self._directory and self.isGitRepo(self._directory):
            self._generateData()
            self._generateAuthorsData()
        else:
            self._general_data = {key: '' for key in self._general_data}
            self._authors_model = None
        self.projectChanged.emit()
        if self._is_loading:
            self._is_loading = False
            self.loading.emit(False)

    generalData = Property(
        'QVariantMap', getProject, setProject, notify=projectChanged)
