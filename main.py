import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from backend import Backend

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)

    # Set up QQmlApplicationEngine
    engine = QQmlApplicationEngine()
    # Add the current directory to the import path
    engine.addImportPath(sys.path[0])

    # Create the backend and expose it to QML
    backend = Backend()
    engine.rootContext().setContextProperty('backend', backend)

    # Load the QML module
    engine.loadFromModule('App', 'Main' if backend.hasGit else 'QuitWindow')

    if not engine.rootObjects():
        sys.exit(-1)

    # Save recent directories on app exit
    app.aboutToQuit.connect(backend.saveOnExit)

    sys.exit(app.exec())
