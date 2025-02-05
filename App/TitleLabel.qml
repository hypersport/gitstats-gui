import QtQuick
import QtQuick.Controls

Label {
    id: titleLabel
    width: parent.width
    anchors.top: menuBar.bottom
    padding: 10
    Text {
        text: backend.projectName
        anchors.centerIn: parent
        font.pixelSize: 30
    }
}