import QtQuick
import QtCharts
import QtQuick.Layouts
import QtQuick.Controls.Basic

ColumnLayout {
    // anchors.fill: parent
    spacing: 5

    GridLayout {
        columns: 2
        columnSpacing: 0
        rowSpacing: 0
        Label {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            Text {
                text: qsTr("Total:")
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
                text: backend.generalData["total_files"]
                font.pixelSize: 40
                leftPadding: 20
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    ChartView {
        id: yearChartView
        Layout.fillWidth: true
        Layout.fillHeight: true
        antialiasing: true

        LineSeries {
            name: "Yearly Value"
            axisX: yearTimeAxis
            axisY: yearValueAxis

            XYPoint { x: Date.parse("2020-02-01"); y: 20 }
            XYPoint { x: Date.parse("2020-03-01"); y: 30 }
            XYPoint { x: Date.parse("2020-04-01"); y: 45 }
            XYPoint { x: Date.parse("2020-05-01"); y: 28 }
            XYPoint { x: Date.parse("2020-07-01"); y: 45 }
            XYPoint { x: Date.parse("2020-09-01"); y: 15 }
            XYPoint { x: Date.parse("2020-10-01"); y: 75 }
            XYPoint { x: Date.parse("2020-11-01"); y: 185 }

            onHovered: (point, state) => {
                let content = "Date: " + Qt.formatDateTime(new Date(point.x), "yyyy-MM") + "\nValue: " + point.y.toFixed(2)
                chartsTooltip.show(yearChartView, point, state, content)
            }
        }
        DateTimeAxis {
            id: yearTimeAxis
            format: "yyyy-MM"
            titleText: "Month"
            //min: new Date(2020, 1, 1)
            //max: new Date(2020, 10, 1)
            tickCount: 8
        }

        ValueAxis {
            id: yearValueAxis
            min: 0
            //max: 90
            tickCount: 8
            titleText: "Value"
        }
    }
    ChartView {
        id: monthChartView
        Layout.fillWidth: true
        Layout.fillHeight: true
        antialiasing: true

        LineSeries {
            name: "Monthly Value"
            axisX: monthTimeAxis
            axisY: monthValueAxis

            XYPoint { x: Date.parse("2020-02-01"); y: 20 }
            XYPoint { x: Date.parse("2020-03-01"); y: 30 }
            XYPoint { x: Date.parse("2020-04-01"); y: 45 }
            XYPoint { x: Date.parse("2020-05-01"); y: 28 }
            XYPoint { x: Date.parse("2020-07-01"); y: 45 }
            XYPoint { x: Date.parse("2020-09-01"); y: 15 }
            XYPoint { x: Date.parse("2020-10-01"); y: 75 }
            XYPoint { x: Date.parse("2020-11-01"); y: 185 }

            onHovered: (point, state) => {
                let content = "Date: " + Qt.formatDateTime(new Date(point.x), "yyyy-MM") + "\nValue: " + point.y.toFixed(2)
                chartsTooltip.show(monthChartView, point, state, content)
            }
        }
        DateTimeAxis {
            id: monthTimeAxis
            format: "yyyy-MM"
            titleText: "Month"
            //min: new Date(2020, 1, 1)
            //max: new Date(2020, 10, 1)
            tickCount: 8
        }

        ValueAxis {
            id: monthValueAxis
            min: 0
            //max: 90
            tickCount: 8
            titleText: "Value"
        }
    }
}