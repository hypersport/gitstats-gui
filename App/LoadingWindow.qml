import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Window {
    id: loadingWindow
    modality: Qt.ApplicationModal // Block other operations
    width: loadingLayout.implicitWidth + 40
    height: loadingLayout.implicitHeight + 40
    flags: Qt.FramelessWindowHint

    ColumnLayout {
        id: loadingLayout
        anchors.centerIn: parent
        spacing: 10

        BusyIndicator {
            id: control

            contentItem: Item {
                implicitWidth: 64
                implicitHeight: 64

                Item {
                    id: item
                    x: parent.width / 2 - 32
                    y: parent.height / 2 - 32
                    width: 64
                    height: 64
                    opacity: control.running ? 1 : 0

                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 250
                        }
                    }

                    RotationAnimator {
                        target: item
                        running: control.visible && control.running
                        from: 0
                        to: 360
                        loops: Animation.Infinite
                        duration: 1250
                    }

                    Repeater {
                        id: repeater
                        model: 6

                        Rectangle {
                            id: delegate
                            x: item.width / 2 - width / 2
                            y: item.height / 2 - height / 2
                            implicitWidth: 10
                            implicitHeight: 10
                            radius: 5
                            color: "#21be2b"

                            required property int index

                            transform: [
                                Translate {
                                    y: -Math.min(item.width, item.height) * 0.5 + 5
                                },
                                Rotation {
                                    angle: delegate.index / repeater.count * 360
                                    origin.x: 5
                                    origin.y: 5
                                }
                            ]
                        }
                    }
                }
            }
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("Please wait until the data is loaded.")
            color: "#21be2b"
            font.pixelSize: 20
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("Large projects may take longer.")
            color: "#21be2b"
            font.pixelSize: 20
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
