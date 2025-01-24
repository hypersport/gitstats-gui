import json
import os

from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex


class RecentDirectoriesModel(QAbstractListModel):
    Roles = {
        "directory": Qt.UserRole + 1
    }

    def __init__(self):
        super().__init__()
        self._directories = []

    def rowCount(self, index):
        return len(self._directories)

    def data(self, index, role):
        if not index.isValid() or not (0 <= index.row() < len(self._directories)):
            return None
        if role == self.Roles["directory"]:
            return self._directories[index.row()]
        return None

    def roleNames(self):
        return {v: k.encode() for k, v in self.Roles.items()}

    def addDirectory(self, directory: str):
        """Adds a new directory, ensuring no duplicates and max 10 items."""
        if directory in self._directories:
            self._directories.remove(directory)
        self._directories.insert(0, directory)
        if len(self._directories) > 10:
            self._directories = self._directories[:10]
        self.layoutChanged.emit()

    def saveToFile(self, filepath="cache"):
        """Save the directories to a JSON file."""
        try:
            with open(filepath, "w", encoding="utf-8") as file:
                json.dump(self._directories, file)
        except Exception as e:
            print(f"Error saving directories to file: {e}")

    def loadFromFile(self, filepath="cache"):
        """Load the directories from a JSON file."""
        if not os.path.exists(filepath):
            return
        try:
            with open(filepath, "r", encoding="utf-8") as file:
                directories = json.load(file)
                self._directories = directories[:10]
                self.layoutChanged.emit()
        except Exception as e:
            print(f"Error loading directories from file: {e}")

    def clearDirectories(self):
        """Clear all directories from the list."""
        if self._directories:
            self.beginRemoveRows(QModelIndex(), 0, len(self._directories) - 1)
            self._directories = []
            self.endRemoveRows()

    def getLatestDirectory(self):
        """Returns the latest directory if it exists, or None otherwise."""
        return self._directories[0] if self._directories else None
