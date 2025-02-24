import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: notGitRepoWindow
    title: qsTr("Not A Git Repo")
    modality: Qt.ApplicationModal // Block other operations
    width: notGitRepoColumnLayout.implicitWidth + 40
    height: 100

    ColumnLayout {
        id: notGitRepoColumnLayout
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: qsTr("This Is NOT A Git Repository.")
            font.pixelSize: 20
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
