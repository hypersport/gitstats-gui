import QtQuick

Connections {
    id: connections
    target: backend

    function onCheckGitRepo(isGitRepo) {
        if (!isGitRepo) {
            notGitRepoWindow.show()
        }
    }

    function onLoading(isLoading) {
        if (isLoading) {
            loadingWindow.show()
        } else {
            loadingWindow.close()
        }
    }
}