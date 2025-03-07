import QtQuick
import QtQuick.Controls
import App 1.0

ApplicationWindow {
    visible: true
    minimumHeight: 720
    minimumWidth: 1080
    title: "Git Stats Viewer - " + backend.generalData["name"]

    menuBar: MenuBar {
        id: menuBar
    }

    header: TabBar {
        id: tabBar
    }

    PageStackLayout {
        id: pageStackLayout
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
