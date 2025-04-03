from PySide6.QtCore import QObject, Signal, Slot, Property, QThread
import datetime

from git_command import GitCommand
from recent_directories_model import RecentDirectoriesModel


class GitCommandThread(QThread):
    finished = Signal()

    def __init__(self, git_command, directory, parent=None):
        super().__init__(parent)
        self._git_command = git_command
        self._directory = directory

    def run(self):
        self._git_command.generateGitStats(self._directory)
        self.finished.emit()


class Backend(QObject):
    loading = Signal(bool)
    projectChanged = Signal()
    checkGitRepo = Signal(bool)

    def __init__(self):
        super().__init__()
        self._git_command = GitCommand()
        self._recent_dirs_model = RecentDirectoriesModel()
        self._recent_dirs_model.loadFromFile()
        self._directory = self._recent_dirs_model.getLatestDirectory()
        self._general_data = {'name': '', 'branch': '', 'first_commit_time': '',
                              'last_commit_time': '', 'age': '', 'total_files': '',
                              'total_commits': '', 'total_authors': '', 'total_lines': ''}
        self._git_command_thread = None

    @Property(QObject, constant=True)
    def recentDirsModel(self):
        return self._recent_dirs_model

    def generateGitStats(self):
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

    def getProject(self):
        return self._general_data

    def setProject(self):
        if self._directory and self.isGitRepo(self._directory):
            self._general_data['name'] = self._git_command.getProjectName(
                self._directory)
            self._general_data['branch'] = self._git_command.getCurrentBranch(
                self._directory)
            self._general_data['first_commit_time'] = self._git_command.getFirstCommitTime()
            self._general_data['last_commit_time'] = self._git_command.getLastCommitTime()
            self._general_data['age'] = self._git_command.getAge()
            self._general_data['total_files'] = self._git_command.getTotalFiles()
            self._general_data['total_commits'] = self._git_command.getTotalCommits()
            self._general_data['total_authors'] = self._git_command.getTotalAuthors()
            self._general_data['total_lines'] = self._git_command.getTotalLines()
        else:
            self._general_data = {key: '' for key in self._general_data}
        self._general_data['generated'] = datetime.datetime.now().strftime(
            '%Y-%m-%d %H:%M:%S')
        self.projectChanged.emit()
        self.loading.emit(False)

    generalData = Property(
        'QVariantMap', getProject, setProject, notify=projectChanged)
