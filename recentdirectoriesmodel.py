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

    def rowCount(self, parent=QModelIndex()):
        return len(self._directories)

    def data(self, index, role):
        if not index.isValid() or not (0 <= index.row() < len(self._directories)):
            return None
        if role == self.Roles["directory"]:
            return self._directories[index.row()]
        return None

    def roleNames(self):
        return {v: k.encode() for k, v in self.Roles.items()}

    def addDirectory(self, directory):
        """Adds a new directory, ensuring no duplicates and max 10 items."""
        if directory in self._directories:
            index = self._directories.index(directory)
            self.beginRemoveRows(QModelIndex(), index, index)
            self._directories.remove(directory)
            self.endRemoveRows()
        self.beginInsertRows(QModelIndex(), 0, 0)
        self._directories.insert(0, directory)
        self.endInsertRows()
        if len(self._directories) > 10:
            self.beginRemoveRows(QModelIndex(), 10, len(self._directories) - 1)
            self._directories = self._directories[:10]
            self.endRemoveRows()
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
                self._directories = directories[:10]  # Ensure only 10 directories are loaded
                self.layoutChanged.emit()  # Notify QML to update the view
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
