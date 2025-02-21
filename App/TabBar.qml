import QtQuick
import QtQuick.Controls.Basic

TabBar {
    id: tabBar
    width: parent.width

    background: Rectangle {
        color: "#eeeeee"
    }

    Repeater {
        model: ["General", "Activity", "Authors", "Files", "Lines", "Tags"]

        TabButton {
            text: modelData
        }
    }
}