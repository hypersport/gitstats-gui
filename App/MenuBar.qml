import QtQuick
import QtQuick.Controls.Basic

MenuBar {
    id: menuBar
    width: parent.width

    FileMenu { }

    HelpMenu { }

    delegate: MenuBarItem {
        id: menuBarItem

        contentItem: Text {
            text: menuBarItem.text
            font: menuBarItem.font
            opacity: enabled ? 1.0 : 0.3
            color: menuBarItem.highlighted ? "#ffffff" : "#21be2b"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 40
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: menuBarItem.highlighted ? "#21be2b" : "transparent"
        }
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        color: "#ffffff"

        Rectangle {
            color: "#21be2b"
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
        }
    }
}