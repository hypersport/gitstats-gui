import QtQuick
import QtQuick.Controls.Basic

Menu {
    title: qsTr("Help")
    Action {
        text: qsTr("About")
        onTriggered: aboutWindow.show()
    }

    topPadding: 2
    bottomPadding: 2

    delegate: MenuItem {
        id: menuItem
        implicitWidth: 70
        implicitHeight: 40

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
            implicitWidth: 70
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: menuItem.highlighted ? "#21be2b" : "transparent"
        }
    }

    background: Rectangle {
        implicitWidth: 70
        implicitHeight: 40
        color: "#ffffff"
        border.color: "#21be2b"
        radius: 2
    }
}
