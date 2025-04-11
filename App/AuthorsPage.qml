import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

ColumnLayout {
    anchors.fill: parent
    spacing: 0

    Button {
        text: qsTr("Back")
        onClicked: {
            console.log(backend.authorsModel.headers)
        }
    }
    // Header Row for Sorting
    RowLayout {
        Layout.fillWidth: true
        spacing: 0

        Repeater {
            model: backend.authorsModel.headers

            Rectangle {
                Layout.fillWidth: true
                height: 40
                color: "lightgray"
                border.color: "gray"

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 0

                    Text {
                        text: modelData
                    }

                    Text {
                        text: (backend.authorsModel.sortedColumn === index)
                              ? (backend.authorsModel.currentSortOrder === Qt.AscendingOrder ? " ↑" : " ↓")
                              : ""
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: backend.authorsModel.toggleSort(index)
                }
            }
        }
    }
    ScrollView {
        id: control
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        // Data Table
        TableView {
            id: tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: backend.authorsModel
            clip: true

            delegate: Rectangle {
                implicitWidth: tableView.width / 4
                implicitHeight: 40
                color: "white"
                border.color: "gray"

                Text {
                    text: model.display
                    anchors.centerIn: parent
                }
            }
        }
        ScrollBar.vertical: ScrollBar {
            // id: verticalScrollBar
            parent: control
            x: control.mirrored ? 0 : control.width - width
            y: control.topPadding
            height: control.availableHeight
            active: control.ScrollBar.horizontal.active
            // contentItem: Rectangle {
            // implicitWidth: 6
            // implicitHeight: 100
            // radius: width / 2
            // color: verticalScrollBar.pressed ? "#81e889" : "#c2f4c6"
            // // Hide the ScrollBar when it's not needed.
            // opacity: verticalScrollBar.policy === ScrollBar.AlwaysOn || (verticalScrollBar.active && verticalScrollBar.size < 1.0) ? 0.75 : 0

            // // Animate the changes in opacity (default duration is 250 ms).
            // Behavior on opacity {
            // NumberAnimation {}
            // }
            // }
        }

        ScrollBar.horizontal: ScrollBar {
            parent: control
            x: control.leftPadding
            y: control.height - height
            width: control.availableWidth
            active: control.ScrollBar.vertical.active
        }

        background: Rectangle {
            border.color: control.activeFocus ? "#21be2b" : "#bdbebf"
        }
    }
}