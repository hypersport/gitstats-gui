import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from backend import Backend

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)

    # Set up QQmlApplicationEngine
    engine = QQmlApplicationEngine()
    
    # Create the backend and expose it to QML
    backend = Backend()
    engine.rootContext().setContextProperty('backend', backend)

    # Load the QML module
    if getattr(sys, 'frozen', False):
        qml_model_path = sys._MEIPASS
    else:
        qml_model_path = sys.path[0]

    engine.addImportPath(qml_model_path)
    engine.loadFromModule('App', 'Main' if backend.hasGit else 'QuitWindow')

    if not engine.rootObjects():
        sys.exit(-1)

    # Save recent directories on app exit
    app.aboutToQuit.connect(backend.saveOnExit)

    sys.exit(app.exec())
