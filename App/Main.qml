import QtQuick
import QtQuick.Controls.Basic
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

    LoadingWindow {
        id: loadingWindow
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

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: "#ffffff" }
            GradientStop { position: 1; color: "#c1bbf9" }
        }
    }
}
