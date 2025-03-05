import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

ColumnLayout {
    anchors.fill: parent

    Text {
        text: qsTr("Git Stats Viewer")
        font.pixelSize: 40
        Layout.alignment: Qt.AlignHCenter
        topPadding: 10
        bottomPadding: 10
    }

}
