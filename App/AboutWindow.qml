import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: aboutWindow
    title: "About"
    modality: Qt.ApplicationModal  // Block other operations
    width: aboutColumnLayout.implicitWidth + 20
    height: aboutColumnLayout.implicitHeight + 20

    ColumnLayout {
        id: aboutColumnLayout
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: "Git Stats Viewer"
            font.pixelSize: 20
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Version: 0.0.1"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Developed by: Hypersport"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "https://github.com/hypersport/gitstats-gui"
            font.pixelSize: 16
            color: "blue"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally("https://github.com/hypersport/gitstats-gui")
                }
            }
        }
    }
}
