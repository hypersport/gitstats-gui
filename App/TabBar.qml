import QtQuick
import QtQuick.Controls.Basic

TabBar {
    id: tabBar
    width: parent.width

    Repeater {
        model: [qsTr("General"), qsTr("Authors"), qsTr("Activity"),
                qsTr("Files"), qsTr("Lines"), qsTr("Tags")]

        TabButton {
            text: modelData
        }
    }
}
