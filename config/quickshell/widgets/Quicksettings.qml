import "root:/config"
import "root:/utils"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Scope {
	id: root

    property bool shouldShowQuicksettings: false

    LazyLoader {
        active: root.shouldShowQuicksettings

        PanelWindow {
            id: rootWindow
            exclusionMode: ExclusionMode.Ignore

            anchors.top: true
            anchors.right: true
            margins.right: screen.width * 0.005
            margins.top: screen.height / 15

            implicitWidth: 500
            implicitHeight: columnLayout.height * 1.14
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: Appearance.colors.surface
                radius: Appearance.radii.large * 1.5
                
                WrapperItem {
                    margin: 16 
                
                    ColumnLayout {
                        id: columnLayout
                        spacing: 10

                        QuicksettingsHeaderBar {
                            Layout.minimumWidth: rootWindow.width - 16*2

                            closeFunction: function() {
                                root.shouldShowQuicksettings = false
                            }
                        }

                        RowLayout {
                            spacing: 10

                            // init Process
                            Process {
                                command: ["echo", "hi"]
                                running: true

                                stdout: StdioCollector {
                                    onStreamFinished: {
                                        networkState.onStateChanged()
                                        bluetoothState.onStateChanged()
                                    }
                                }
                            }

                            Connections {
                                id: networkState
                                target: NetworkState

                                function onStateChanged() {
                                    var jsonData = JSON.parse(NetworkState.state)

                                    networkTile.title = jsonData.name
                                    networkTile.iconPath = jsonData.icon
                                    networkTile.summary = jsonData.state
                                }
                            }

                            Process {
                                id: networkProc
                                command: ["/home/kaii/.config/quickshell/scripts/network_util.sh", "toggle"]

                                running: false
                            }

                            QsTile {
                                id: networkTile
                                hasExtra: true
                                title: "Jaxx"
                                summary: "Connected"
                                active: networkTile.summary != "Powered Off"
                                iconPath: "/home/kaii/.config/quickshell/assets/wifi_connected.svg"
                                command: function() {
                                    networkProc.running = true
                                }
                                secondCommand: "notify-send \"not implemented\""
                            }

                            Connections {
                                id: bluetoothState
                                target: BluetoothState

                                function onStateChanged() {
                                    var jsonData = JSON.parse(BluetoothState.state)
                                    var batteryLevel = ""

                                    if (jsonData.battery != -1) {
                                        batteryLevel = " - " + jsonData.battery + "%"
                                    }

                                    var powered = jsonData.powered === "true"
                                    
                                    bluetoothTile.summary = powered ? (jsonData.connected_device + batteryLevel) : "Powered Off"
                                }
                            }

                            Process {
                                id: bluetoothProc
                                command: ["/home/kaii/.config/quickshell/scripts/bluetooth_util.sh", "toggle"]

                                running: false
                            }

                            QsTile {
                                id: bluetoothTile
                                hasExtra: true
                                title: "Bluetooth"
                                summary: "Powered Off"
                                active: bluetoothTile.summary != "Powered Off"
                                iconPath: "/home/kaii/.config/quickshell/assets/bluetooth_on.svg"
                                command: function() {
                                    bluetoothProc.running = true
                                }
                                secondCommand: "notify-send \"not implemented\""
                            }
                        }

                        RowLayout {
                            spacing: 10

                            Process {
                                id: caffieneProc
                                command: ["python3", "/home/kaii/.config/eww/scripts/idleinhibit.py"]

                                running: false
                            }

                            QsTile {
                                id: caffieneTile
                                title: "Caffiene"
                                summary: caffieneProc.running ? "Active" : "Inactive"
                                iconPath: "/home/kaii/.config/quickshell/assets/caffiene.svg"
                                active: caffieneProc.running
                                command: function() {
                                    caffieneProc.running = !caffieneProc.running
                                }
                            }

                            QsTile {
                                id: dndTile
                                title: "Notifications"
                                summary: "Hidden"
                                active: false
                                iconPath: "/home/kaii/.config/quickshell/assets/notifications_filled_off.svg"
                                command: function() {
                                    // TODO: complete this
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}