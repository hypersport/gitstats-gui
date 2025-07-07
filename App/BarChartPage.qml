import QtQuick
import QtCharts
import QtQuick.Layouts
import QtQuick.Controls.Basic

ColumnLayout {
    // anchors.fill: parent
    id: control
    property var dataOfYearModel
    property var dataOfMonthModel

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
                max: getMaxValue(control.dataOfYearModel)
            }
            BarSet {
                label: "Yearly Stats"
                values: control.dataOfYearModel
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
                labelsAngle: 90
            }
            axisY: ValueAxis {
                min: 0
                max: getMaxValue(control.dataOfMonthModel)
            }
            BarSet {
                label: "Monthly Stats"
                values: control.dataOfMonthModel
            }
        }
    }

    function getMaxValue(data) {
        return data.length > 0 ? Math.max(...data) : 10
    }
}