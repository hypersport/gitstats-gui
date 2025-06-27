import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Page {
    header: TabBar {
        id: authoursTabBar
        width: parent.width

        Repeater {
            model: [qsTr("General"), qsTr("Authors Of Year"), qsTr("Authors Of Month")]

            TabButton {
                id: tabButton
                text: modelData
                contentItem: Text {
                    text: tabButton.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: authoursTabBar.currentIndex === index ? "#818181" : "transparent"
                }
            }
        }
    }

    StackLayout {
        id: authoursStackLayout
        currentIndex: authoursTabBar.currentIndex
        anchors.fill: parent

        AuthorsGeneralPage {
            id: authorsGeneralPage
        }
        AuthorsOfYearPage {
            id: authorsOfYearPage
        }
        AuthorsOfMonthPage {
            id: authorsOfMonthPage
        }
    }

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: "#ffffff" }
            GradientStop { position: 1; color: "#c1bbf9" }
        }
    }
}