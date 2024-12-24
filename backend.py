from PySide6.QtCore import QObject, Slot, Property

from recentdirectoriesmodel import RecentDirectoriesModel


class Backend(QObject):

    def __init__(self):
        super().__init__()
        self._recent_dirs_model = RecentDirectoriesModel()
        self._recent_dirs_model.loadFromFile()
        self._directory = self._recent_dirs_model.getLatestDirectory()

    @Property(QObject, constant=True)
    def recentDirsModel(self):
        return self._recent_dirs_model

    @Slot(str)
    def setDirectory(self, path: str):
        """Set the directory path."""
        self._directory = path
        self._recent_dirs_model.addDirectory(path)

    def saveOnExit(self):
        """Save the cache file."""
        self._recent_dirs_model.saveToFile()

    @Slot()
    def clearRecentDirectories(self):
        """Clears the recent directories."""
        self._recent_dirs_model.clearDirectories()
