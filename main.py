import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from backend import Backend

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    # Set up QQmlApplicationEngine
    engine = QQmlApplicationEngine()
    engine.addImportPath(sys.path[0])  # Add the current directory to the import path

    # Create the backend and expose it to QML
    backend = Backend()
    engine.rootContext().setContextProperty("backend", backend)

    # Load the QML module
    engine.loadFromModule("App", "Main")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
