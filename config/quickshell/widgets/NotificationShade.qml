import "root:/config"
import "root:/osds"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Scope {
	id: root

    property bool showNotificationShade: true // false

    ListModel {
        id: notifModel
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: notifProc.running = true
    }

    LazyLoader {
        active: root.showNotificationShade

        PanelWindow {
            id: rootWindow
            exclusionMode: ExclusionMode.Ignore

            Component.onCompleted: {
				if (this.WlrLayershell != null) {
					this.WlrLayershell.layer = WlrLayer.Overlay;
				}
			}

            anchors.top: true
            anchors.right: true
            margins.right: screen.width * 0.005
            margins.top: screen.height / 15

            implicitWidth: 500
            implicitHeight: 600
            color: "transparent"

            ClippingRectangle {
                anchors.fill: parent
                color: Appearance.colors.surface
                radius: Appearance.radii.large * 1.5
                
                WrapperItem {
                    margin: 16
                
                    ColumnLayout {
                        id: columnLayout
                        spacing: 10

                        implicitWidth: rootWindow.width - 16*2

                        Behavior on implicitHeight {
                            animation: Appearance.animations.elementMoveEnter.numberAnimation.createObject(this)
                        }

                        NotificationShadeHeader {
                            Layout.minimumWidth: rootWindow.width - 22*2

                            closeFunction: function() {
                                root.showNotificationShade = false
                            }
                        }

                        Rectangle {
                            width: columnLayout.width - 4*2
                            height: 2
                            
                            color: Appearance.colors.surfaceLight
                            radius: Appearance.radii.large
                            opacity: 0.5

                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: Appearance.spacing.normal
                            Layout.bottomMargin: Appearance.spacing.normal
                        }

                        ClippingRectangle {
                            height: notifModel.count > 0 ? rootWindow.height - 50*2 : 0
                            width: columnLayout.width
                            color: "transparent"
                            radius: Appearance.radii.large

                            ListView {
                                id: notifListView
                                model: notifModel
                                cacheBuffer: 100

                                height: parent.height
                                width: parent.width

                                Layout.alignment: Qt.AlignTop + Qt.AlignLeft

                                spacing: Appearance.spacing.large

                                delegate: NotificationItem {
                                    implicitWidth: columnLayout.width

                                    refresh: function() {
                                        notifProc.running = true
                                    }
                                }
                            }

                            Process {
                                id: notifProc
                                command: ["/home/kaii/.config/quickshell/scripts/get_notif.sh"]

                                running: true

                                stdout: SplitParser {
                                    onRead: data => {
                                        var list = JSON.parse(data)

                                        var old = notifListView.contentY

                                        notifModel.clear()
                                        list.forEach(function(item) {
                                            notifModel.append(item)
                                        })

                                        notifListView.contentY = old
                                    }
                                }
                            }
                        }

                        WrapperRectangle {
                            height: notifModel.count == 0 ? 500 : 0
                            color: "transparent"

                            Layout.alignment: Qt.AlignHCenter + Qt.AlignVCenter
                            Layout.topMargin: columnLayout.height * 0.65

                            Text {
                                text: "Nothing Here"
                                color: Appearance.colors.text
                                opacity: notifModel.count == 0 ? 0.8 : 0
                                font.pointSize: 22
                            }
                        }
                    }
                }
            }
        }
    }
}