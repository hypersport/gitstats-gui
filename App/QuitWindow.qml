import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    title: qsTr("No Git Found")
    modality: Qt.ApplicationModal  // Block other operations
    width: quitColumnLayout.implicitWidth + 20
    height: quitColumnLayout.implicitHeight + 20

    ColumnLayout {
        id: quitColumnLayout
        anchors.centerIn: parent
        spacing: 20
        Text {
            text: qsTr("Git is NOT found on your computer")
            font.pixelSize: 20
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: qsTr("Please make sure you have installed git and added to path")
            font.pixelSize: 20
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: qsTr("You can download git from Official Website")
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "https://git-scm.com/downloads"
            font.pixelSize: 16
            color: "blue"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally("https://git-scm.com/downloads")
                    Qt.quit()
                }
            }
        }
    }
}
