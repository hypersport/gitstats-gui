import QtQuick
import QtQuick.Controls
import App 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Git Stats Viewer"

    Column {
        spacing: 10
        anchors.centerIn: parent

        // Use the DirectoryInput component
        DirectoryInput {
            id: directoryInput
        }
    }
}