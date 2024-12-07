from PySide6.QtCore import QObject, Signal, Slot


class Backend(QObject):

    def __init__(self):
        super().__init__()
        self._directory = ""

    @Slot(result=str)
    def getDirectory(self):
        """Return the currently selected directory path."""
        return self._directory

    @Slot(str)
    def setDirectory(self, path: str):
        """Set the directory path."""
        self._directory = path
