import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

StackLayout {
    id: stackLayout
    currentIndex: tabBar.currentIndex
    anchors.fill: parent

    GeneralPage {
    }
    // ActivityPage {}
    // AuthorsPage {}
    // FilesPage {}
    // LinesPage {}
    // TagsPage {}
}

