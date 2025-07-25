import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

ColumnLayout {
    // anchors.fill: parent
    id: control
    property var authorsModel

    spacing: 0

    // Header Row for Sorting
    RowLayout {
        Layout.fillWidth: true
        spacing: 0

        Repeater {
            model: control.authorsModel.headers

            Rectangle {
                Layout.preferredWidth: index < 2 ? control.width / 12 : control.width / 5
                height: 40
                color: control.authorsModel.sortedColumn === index ? "#bdbebf" : "transparent"

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 0

                    Text {
                        text: modelData
                    }
                    Text {
                        text: (control.authorsModel.sortedColumn === index)
                              ? (control.authorsModel.currentSortOrder === Qt.AscendingOrder ? " ↑" : " ↓")
                              : ""
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: control.authorsModel.toggleSort(index)
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
        id: scrollView
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        // Data Table
        TableView {
            id: tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: control.authorsModel
            clip: true

            delegate: Rectangle {
                implicitWidth: model.column < 2 ? tableView.width / 12 : tableView.width / 5
                implicitHeight: 40
                color: model.row % 2 === 1 ? "#81e889" : "transparent"
                Text {
                    text: model.display
                    anchors.centerIn: parent
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            parent: scrollView
            x: scrollView.mirrored ? 0 : scrollView.width - width
            y: scrollView.topPadding
            height: scrollView.availableHeight
            active: scrollView.ScrollBar.horizontal.active
        }

        ScrollBar.horizontal: ScrollBar {
            parent: scrollView
            x: scrollView.leftPadding
            y: scrollView.height - height
            width: scrollView.availableWidth
            active: scrollView.ScrollBar.vertical.active
        }
    }
}