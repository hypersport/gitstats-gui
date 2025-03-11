import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

GridLayout {
    columns: 2
    columnSpacing: 0
    rowSpacing: 0

    // Project Name
    Label {
        Layout.columnSpan: 2
        Layout.fillWidth: true
        Layout.preferredHeight: 60
        Text {
            text: backend.generalData["name"]
            font.pixelSize: 40
            anchors.centerIn: parent
        }
    }

    // Generate Time
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: qsTr("Generated At :")
            font.pixelSize: 20
            rightPadding: 20
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
        background: Rectangle {
            color: "#21be2b"
        }
    }
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: backend.generalData["generated"]
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
        background: Rectangle {
            color: "#21be2b"
        }
    }

    // Git Version
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: qsTr("Git Version :")
            font.pixelSize: 20
            rightPadding: 20
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: backend.generalData["git"]
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // Git Branch
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: qsTr("Git Branch :")
            font.pixelSize: 20
            rightPadding: 20
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
        background: Rectangle {
            color: "#21be2b"
        }
    }
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: backend.generalData["branch"]
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
        background: Rectangle {
            color: "#21be2b"
        }
    }

    // Git Version
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: qsTr("Project Period :")
            font.pixelSize: 20
            rightPadding: 20
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: backend.generalData["first_commit_time"] + " - " + backend.generalData["last_commit_time"]
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
