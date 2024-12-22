import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import App 1.0

ApplicationWindow {
    visible: true
    height: 720
    width: 1080
    title: "Git Stats Viewer"

    menuBar: MenuBar {
        width: parent.width
        Menu {
            width: parent.parent.width / 3
            title: "File"
            MenuItem {
                text: "Open"
                onTriggered: folderDialog.open()
            }
            MenuSeparator {
            }
            Repeater {
                model: backend.recentDirsModel
                delegate: MenuItem {
                    Text {
                        width: parent.width
                        text: (index + 1) + ". " + model.directory
                        elide: Text.ElideMiddle
                    }
                    ToolTip {
                        visible: hovered
                        text: model.directory
                        background: Rectangle {
                            border.color: "black"
                            radius: 5
                        }
                    }
                    onTriggered: backend.setDirectory(model.directory)
                }
            }
            MenuSeparator {
            }
            MenuItem {
                text: "Clean"
                onTriggered: backend.clearRecentDirectories()
            }
            MenuSeparator {
            }
            MenuItem {
                text: "Exit"
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: "Help"
            Action {
                text: "About"
                onTriggered: {
                    console.log("About");
                }
            }
        }
    }
    FolderDialog {
        id: folderDialog
        onAccepted: {
            let folderPath = folderDialog.selectedFolder.toString()
            let path = folderPath.slice(8)
            backend.setDirectory(path)
        }
    }
}
