import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import App 1.0

Item {
    width: 300
    height: 40

    TextField {
        id: directoryInput
        placeholderText: "Click to select a directory..."
        text: backend.getDirectory()
        readOnly: true
        width: parent.width

        MouseArea {
            anchors.fill: parent
            onClicked: folderDialog.open()
        }
    }

    FolderDialog {
        id: folderDialog
        onAccepted: {
            let folderPath = folderDialog.selectedFolder.toString()
            let path = folderPath.slice(8)
            backend.setDirectory(path)  // Update backend with the selected folder
            directoryInput.text = path  // Update the TextField
        }
    }
}
