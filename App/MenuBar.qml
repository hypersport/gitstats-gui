import QtQuick
import QtQuick.Controls

MenuBar {
    id: menuBar
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
        MenuItem {
            text: "About"
            onTriggered: aboutWindow.show()
        }
    }
}