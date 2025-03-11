from PySide6.QtCore import QObject, Signal, Slot, Property
import datetime

from git_command import GitCommand
from recent_directories_model import RecentDirectoriesModel


class Backend(QObject):
    projectChanged = Signal()
    checkGitRepo = Signal(bool)

    def __init__(self):
        super().__init__()
        self._git_command = GitCommand()
        self._recent_dirs_model = RecentDirectoriesModel()
        self._recent_dirs_model.loadFromFile()
        self._directory = self._recent_dirs_model.getLatestDirectory()
        self._general_data = {'name': 'Choose Git Project First',
                              'branch': 'Choose Git Project First',
                              'first_commit_time': 'Choose Git Project First',
                              'last_commit_time': 'Choose Git Project First'}
        self.setProject()

    @Property(QObject, constant=True)
    def recentDirsModel(self):
        return self._recent_dirs_model

    @Slot(str)
    def setDirectory(self, path: str):
        if self.isGitRepo(path):
            self._directory = path
            self._recent_dirs_model.addDirectory(path)
            self.setProject()

    @Slot(str)
    def openDirectory(self, path: str):
        if self.isGitRepo(path):
            self._directory = path
            self._recent_dirs_model.addDirectory(path)
            self.setProject()

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
            self._git_command.generateCommitInfo(self._directory)
            self._general_data['first_commit_time'] = self._git_command.getFirstCommitTime()
            self._general_data['last_commit_time'] = self._git_command.getLastCommitTime()
        self._general_data['generated'] = datetime.datetime.now().strftime(
            '%Y-%m-%d %H:%M:%S')
        self.projectChanged.emit()

    generalData = Property(
        'QVariantMap', getProject, setProject, notify=projectChanged)
