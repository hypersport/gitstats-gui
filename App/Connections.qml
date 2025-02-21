import QtQuick

Connections {
    id: connections
    target: backend

    function onCheckGitRepo(isGitRepo) {
        if (!isGitRepo) {
            notGitRepoWindow.show()
        }
    }
}