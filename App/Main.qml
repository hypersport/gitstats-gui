import QtQuick
import QtQuick.Controls
import App 1.0

ApplicationWindow {
    visible: true
    height: 720
    width: 1080
    title: "Git Stats Viewer"

    MenuBar {
        id: menuBar
    }

    FolderDialog {
        id: folderDialog
    }

    AboutWindow {
        id: aboutWindow
    }
}
