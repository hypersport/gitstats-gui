import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    title: "No Git Found"
    modality: Qt.ApplicationModal  // Block other operations
    width: quitColumnLayout.implicitWidth + 20
    height: quitColumnLayout.implicitHeight + 20

    ColumnLayout {
        id: quitColumnLayout
        anchors.centerIn: parent
        spacing: 20
        Text {
            text: "Git was NOT found on your computer, please make sure you have installed git and add to path"
            font.pixelSize: 20
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
                }
            }
        }

        Button {
            text: "Quit"
            Layout.alignment: Qt.AlignHCenter
            onClicked: Qt.quit()
        }
    }
}
