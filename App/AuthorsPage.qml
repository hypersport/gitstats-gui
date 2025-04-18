import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

ColumnLayout {
    // anchors.fill: parent
    spacing: 0

    // Header Row for Sorting
    RowLayout {
        Layout.fillWidth: true
        spacing: 0

        Repeater {
            model: authorsModel.headers

            Rectangle {
                Layout.fillWidth: true
                height: 40
                color: authorsModel.sortedColumn === index ? "#bdbebf" : "transparent"

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 0

                    Text {
                        text: modelData
                    }
                    Text {
                        text: (authorsModel.sortedColumn === index)
                              ? (authorsModel.currentSortOrder === Qt.AscendingOrder ? " ↑" : " ↓")
                              : ""
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: authorsModel.toggleSort(index)
                }
            }
        }
    }
    Rectangle {
        color: "#000000"
        Layout.fillWidth: true
        height: 1
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
            model: authorsModel
            clip: true

            delegate: Rectangle {
                implicitWidth: tableView.width / 10
                implicitHeight: 40
                color: model.row % 2 === 1 ? "#21be2b" : "transparent"
                Text {
                    text: model.display
                    anchors.centerIn: parent
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            parent: control
            x: control.mirrored ? 0 : control.width - width
            y: control.topPadding
            height: control.availableHeight
            active: control.ScrollBar.horizontal.active
        }

        ScrollBar.horizontal: ScrollBar {
            parent: control
            x: control.leftPadding
            y: control.height - height
            width: control.availableWidth
            active: control.ScrollBar.vertical.active
        }
    }
}