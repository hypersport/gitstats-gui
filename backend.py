from PySide6.QtCore import QObject, Signal, Slot


class Backend(QObject):

    def __init__(self):
        super().__init__()
        try:
            with open("cache", "r") as file:
                lines = file.readlines()
            if len(lines) > 10:
                lines = lines[-10:]
                with open("cache", "w") as file:
                    file.writelines(lines)
        except FileNotFoundError:
            lines = []
        self._directory = lines[-1] if lines else ""

    @Slot(result=str)
    def getDirectory(self):
        """Return the currently selected directory path."""
        return self._directory

    @Slot(str)
    def setDirectory(self, path: str):
        """Set the directory path."""
        self._directory = path
        with open("cache", "a") as file:
            file.write(f"{path}\n")
