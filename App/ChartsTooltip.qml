import QtQuick
import QtQuick.Controls

Item {
    id: root
    visible: false
    z: 1000
    width: tooltipBox.implicitWidth + 16
    height: tooltipBox.implicitHeight + 16

    Rectangle {
        id: tooltipBox
        color: "black"
        radius: 6
        width: 100
        height: 40
        border.color: "white"
        border.width: 1
        opacity: 0.9

        Text {
            id: tooltipText
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 12
        }

        // Rectangle {
        //     width: 6
        //     height: 6
        //     radius: 4
        //     color: "red"
        //     border.width: 0
        //     anchors.right: parent.left
        //     anchors.verticalCenter: parent.bottom
        // }
    }

    function show(chart, point, state, text) {
        root.visible = state
        if (state) {
            tooltipText.text = text
            let pos = chart.mapToItem(chart.parent, chart.mapToPosition(point))
            root.x = pos.x  // + 5
            root.y = pos.y  // - tooltipBox.height - 5
        }
    }
}
