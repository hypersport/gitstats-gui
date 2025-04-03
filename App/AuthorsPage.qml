import QtQuick
import QtQuick.Controls.Basic

ScrollView {
    id: scrollView
    anchors.fill: parent

    TableView {
        id: tableView
        anchors.fill: parent
        model: backend.authorsModel
        clip: true
        columnSpacing: 10
        rowSpacing: 10
    }
}