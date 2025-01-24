from PySide6.QtCore import QObject, Signal, Slot, Property

from git_command import GitCommand
from recent_directories_model import RecentDirectoriesModel


class Backend(QObject):
    def __init__(self):
        super().__init__()
        self._git_command = GitCommand()
        self._recent_dirs_model = RecentDirectoriesModel()
        self._recent_dirs_model.loadFromFile()
        self._directory = self._recent_dirs_model.getLatestDirectory()

    @Property(QObject, constant=True)
    def recentDirsModel(self):
        return self._recent_dirs_model

    @Slot(str)
    def setDirectory(self, path: str):
        self._directory = path
        self._recent_dirs_model.addDirectory(path)

    @Slot(str)
    def openDirectory(self, path: str):
        self._directory = path
        self._recent_dirs_model.addDirectory(path)

    def saveOnExit(self):
        self._recent_dirs_model.saveToFile()

    @Slot()
    def clearRecentDirectories(self):
        self._recent_dirs_model.clearDirectories()

    @property
    def hasGit(self):
        return self._git_command.hasGit()
