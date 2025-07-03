import QtQuick
import QtCharts
import QtQuick.Layouts
import QtQuick.Controls.Basic

ColumnLayout {
    // anchors.fill: parent
    spacing: 0

    GridLayout {
        columns: 2
        columnSpacing: 0
        rowSpacing: 0

        Label {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            Text {
                text: qsTr("Total Files :")
                font.pixelSize: 40
                rightPadding: 20
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Label {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            Text {
                text: "101"
                font.pixelSize: 40
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    ChartView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        antialiasing: true

        LineSeries {
            XYPoint { x: 0; y: 0 }
            XYPoint { x: 1.1; y: 2.1 }
            XYPoint { x: 1.9; y: 3.3 }
            XYPoint { x: 2.1; y: 2.1 }
            XYPoint { x: 2.9; y: 4.9 }
            XYPoint { x: 3.4; y: 3.0 }
            XYPoint { x: 4.1; y: 3.3 }
        }
    }
}