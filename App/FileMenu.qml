import QtQuick
import QtQuick.Controls.Basic

Menu {
    id: fileMenu
    title: qsTr("File")

    Action {
        text: qsTr("Open")
        onTriggered: folderDialog.open()
    }
    CustomMenuSeparator {}
    
    Menu {
        title: qsTr("Recent")
        enabled: recentDirsMenu.count > 0

        Repeater {
            id: recentDirsMenu
            model: backend.recentDirsModel

            delegate: MenuItem {
                id: repeaterItem
                implicitWidth: 380
                implicitHeight: 40
                text: (index + 1) + ". " + model.directory

                contentItem: Text {
                    leftPadding: 10
                    rightPadding: 10
                    text: repeaterItem.text
                    font: repeaterItem.font
                    opacity: enabled ? 1.0 : 0.3
                    color: repeaterItem.highlighted ? "#ffffff" : "#21be2b"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideMiddle
                }

                background: Rectangle {
                    implicitWidth: 380
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    color: repeaterItem.highlighted ? "#21be2b" : "transparent"
                    Rectangle {
                        color: "#21be2b"
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                    }
                }

                // ToolTip {
                //     id: toolTip
                //     text: model.directory
                //     visible: hovered
                //     anchors.centerIn: repeaterItem
                //     contentItem: Text {
                //         text: toolTip.text
                //         font: toolTip.font
                //         horizontalAlignment: Text.AlignLeft
                //         verticalAlignment: Text.AlignVCenter
                //         color: "#ffffff" 
                //     }

                //     background: Rectangle {
                //         implicitHeight: 40
                //         radius: 2
                //         color: "#21be2b"
                //     }
                // }

                onTriggered: {
                    fileMenu.close()
                    backend.setDirectory(model.directory)
                }
            }
        }
        
        background: Rectangle {
            implicitWidth: 380
            implicitHeight: 40
            color: "#ffffff"
            border.color: "#21be2b"
            radius: 2
        }
    }
    CustomMenuSeparator {}

    Action {
        text: qsTr("Clean")
        onTriggered: backend.clearRecentDirectories()
    }
    CustomMenuSeparator {}

    Action {
        text: qsTr("Exit")
        onTriggered: Qt.quit()
    }

    topPadding: 2
    bottomPadding: 2

    delegate: MenuItem {
        id: menuItem
        implicitWidth: 100
        implicitHeight: 40

        arrow: Canvas {
            x: parent.width - width
            implicitWidth: 40
            implicitHeight: 40
            visible: menuItem.subMenu
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = menuItem.highlighted ? "#ffffff" : "#21be2b"
                ctx.moveTo(15, 15)
                ctx.lineTo(width - 15, height / 2)
                ctx.lineTo(15, height - 15)
                ctx.closePath()
                ctx.fill()
            }
        }

        contentItem: Text {
            leftPadding: 10
            rightPadding: 10
            text: menuItem.text
            font: menuItem.font
            opacity: enabled ? 1.0 : 0.3
            color: menuItem.highlighted ? "#ffffff" : "#21be2b"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: menuItem.highlighted ? "#21be2b" : "transparent"
        }
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        color: "#ffffff"
        border.color: "#21be2b"
        radius: 2
    }
}
