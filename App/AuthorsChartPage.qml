import QtQuick
import QtCharts
import QtQuick.Layouts
import QtQuick.Controls.Basic

ColumnLayout {
    // anchors.fill: parent
    spacing: 5

    ChartView {
        id: yearChartView
        Layout.fillWidth: true
        Layout.fillHeight: true
        antialiasing: true

        BarSeries {
            labelsVisible: true
            labelsPosition: AbstractBarSeries.LabelsInsideEnd

            axisX: BarCategoryAxis {
                categories: backend.yearMonthData.years
            }
            axisY: ValueAxis {
                min: 0
                max: Math.max(...backend.yearMonthData.authorsOfYear)
            }
            BarSet {
                label: "Yearly Stats"
                values: backend.yearMonthData.authorsOfYear
            }
        }
    }

    ChartView {
        id: monthChartView
        Layout.fillWidth: true
        Layout.fillHeight: true
        antialiasing: true

        LineSeries {
            name: "Monthly Stats"
            axisX: monthTimeAxis
            axisY: monthValueAxis

            XYPoint { x: Date.parse("2020-02-01"); y: 20 }
            XYPoint { x: Date.parse("2020-03-01"); y: 30 }
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