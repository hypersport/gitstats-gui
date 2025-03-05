import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

FolderDialog {
    id: folderDialog
    onAccepted: {
        let folderPath = folderDialog.selectedFolder.toString()
        let path = folderPath.replace("file:///", "")
        backend.openDirectory(path)
    }
}