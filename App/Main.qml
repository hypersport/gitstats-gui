import QtQuick
import QtQuick.Controls
import App 1.0

ApplicationWindow {
    visible: true
    height: 720
    width: 1080
    title: "Git Stats Viewer - " + backend.projectName

    MenuBar {
        id: menuBar
    }

    TabBar {
        id: tabBar
        anchors.top: menuBar.bottom
    }

    background: Rectangle {
        color: "white"
    }

    FolderDialog {
        id: folderDialog
    }

    AboutWindow {
        id: aboutWindow
    }

    NotGitRepoWindow {
        id: notGitRepoWindow
    }
    
    Connections {
        id: connections
    }
}
