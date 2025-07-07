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

        BarSeries {
            labelsVisible: true
            labelsPosition: AbstractBarSeries.LabelsInsideEnd

            axisX: BarCategoryAxis {
                categories: backend.yearMonthData.months
            }
            axisY: ValueAxis {
                min: 0
                max: Math.max(...backend.yearMonthData.authorsOfMonth)
            }
            BarSet {
                label: "Monthly Stats"
                values: backend.yearMonthData.authorsOfMonth
            }
        }
    }
}