import QtQuick
import QtQuick.Controls
import App 1.0

ApplicationWindow {
    visible: true
    height: 720
    width: 1080
    title: backend.projectName + " - Git Stats Viewer"

    MenuBar {
        id: menuBar
    }

    Rectangle {
        width: parent.width
        height: 0.5
        color: "lightgray"
        x: 0
        y: menuBar.height - 0.5
    }

    TabBar {
        id: tabBar
        anchors.top: menuBar.bottom
    }

    background: Rectangle {
        color: "white"
    }

    NotGitRepoWindow {
        id: notGitRepoWindow
    }
    
    Connections {
        id: connections
    }
}
