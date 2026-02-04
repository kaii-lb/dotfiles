import "root:/config"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

WrapperRectangle {
    id: root

    required property var appname
    required property var body
    required property var summary
    required property var icon_path
    required property var id
    required property var urgency
    required property var progress
    required property var timestamp

    required property var refresh
    
    Layout.alignment: Qt.AlignHCenter + Qt.AlignTop
    
    color: Appearance.colors.surfacePressed
    radius: Appearance.radii.large
    margin: Appearance.spacing.normal

    Process {
        id: deleteNotifProc
        command: ["dunstctl", "history-rm", root.id.data]

        running: false
    }

    ColumnLayout {
        id: columnLayout

        RowLayout {
            id: notificationShadeHeaderBar
            spacing: 16
            Layout.fillWidth: true
            Layout.rightMargin: 8
            Layout.leftMargin: 8
            Layout.topMargin: 8

            ClippingRectangle {
                radius: Appearance.radii.full
                Layout.preferredWidth: 56
                Layout.preferredHeight: 56

                Layout.alignment: Qt.AlignLeft

                color: Appearance.colors.surfacePressed
            
                IconImage {
                    source: 
                        if (root.icon_path.data == "") {
                            Qt.resolvedUrl("/home/kaii/.config/quickshell/assets/notifications_filled.svg")
                        } else {
                            Qt.resolvedUrl(root.icon_path.data)
                        }
                    
                    implicitSize: parent.height
                }
            }

            ColumnLayout {
                Text {
                    text: (appname.data == "" ? "unknown" : appname.data) + " - " + timestamp.data
                    color: Appearance.colors.text
                    opacity: 0.8
                    font.pointSize: 12
                    Layout.alignment: Qt.AlignLeft + Qt.AlignTop
                }

                Text {
                    text: summary.data
                    color: Appearance.colors.text
                    font.pointSize: 13
                    Layout.alignment: Qt.AlignLeft + Qt.AlignBottom
                }
            }

            Rectangle {
                width: 12
                height: 12
                radius: Appearance.radii.large

                color: if (urgency.data == "CRITICAL") {
                    Appearance.colors.primary
                } else if (urgency.data == "LOW") {
                    Appearance.colors.secondary
                } else {
                    "transparent"
                }

                Layout.alignment: Qt.AlignTop
                Layout.topMargin: 14
            }

            Rectangle {
                Layout.fillWidth: true
                color: "transparent"
            }

            MouseArea {
                id: notificationItemCloseMouseArea

                Layout.alignment: Qt.AlignTop

                width: 36
                height: 36

                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton

                onClicked: function() {
                    deleteNotifProc.running = true
                    root.refresh()
                }

                Rectangle {
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    color: notificationItemCloseMouseArea.pressed ? Appearance.colors.surfacePressed : Appearance.colors.surfaceLight
                    radius: Appearance.radii.full
                }
                
                IconImage {
                    source: Qt.resolvedUrl("/home/kaii/.config/quickshell/assets/close.svg")
                    implicitSize: 24
                    anchors.centerIn: parent
                }
            }
        }

        WrapperItem {
            margin: 16 

            Text {
                text: body.data
                color: Appearance.colors.text
                font.pointSize: 13
                Layout.alignment: Qt.AlignLeft + Qt.AlignBottom
                Layout.fillWidth: true
            }
        }

        RowLayout {
            height: root.progress.data == -1 ? 0 : 8
            width: columnLayout.width - 24*2
            Layout.leftMargin: 24
            Layout.bottomMargin: root.progress.data == -1 ? 0 : 16

            Rectangle {
                height: parent.height
                width: parent.width * root.progress.data
                color: Appearance.colors.primary
                radius: Appearance.radii.large
            }
        }
    }
}