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

    // Project Period
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

    // Project Age
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: qsTr("Project Age :")
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
            text: backend.generalData["age"] + " days ( " + (backend.generalData["age"] / 7).toFixed(1) + " weeks, " + (backend.generalData["age"] / 30).toFixed(1) + " months )"
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
        background: Rectangle {
            color: "#21be2b"
        }
    }

    // Total Files
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: qsTr("Total Files :")
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
            text: backend.generalData["total_files"]
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // Total Commits
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: qsTr("Total Commits :")
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
            text: backend.generalData["total_commits"]
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
        background: Rectangle {
            color: "#21be2b"
        }
    }

    // Total Authors
    Label {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Text {
            text: qsTr("Total Authors :")
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
            text: backend.generalData["total_authors"]
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
