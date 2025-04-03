import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

StackLayout {
    id: stackLayout
    currentIndex: tabBar.currentIndex
    anchors.fill: parent

    GeneralPage {
        id: generalPage
    }
    AuthorsPage {
        id: authorsPage
    }
    // ActivityPage {}
    // FilesPage {}
    // LinesPage {}
    // TagsPage {}
}

