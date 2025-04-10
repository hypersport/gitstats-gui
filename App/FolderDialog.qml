import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

FolderDialog {
    id: folderDialog
    onAccepted: {
        let path = folderDialog.selectedFolder.toString()
        backend.openDirectory(path)
    }
}