import "root:/config"
import "root:/utils"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
	id: root

    property bool shouldShowQuicksettings: false

    LazyLoader {
        active: root.shouldShowQuicksettings

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
            implicitHeight: columnLayout.height + 32
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

                        Behavior on implicitHeight {
                            animation: Appearance.animations.elementMoveEnter.numberAnimation.createObject(this)
                        }

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
                                id: caffieneCheckProc
                                command: ["/home/kaii/.config/quickshell/scripts/caffiene.sh", "check"]

                                running: true

                                stdout: StdioCollector {
                                    onStreamFinished: {
                                        caffieneTile.summary = this.text === "true\n" ? "Active" : "Inactive"
                                    }
                                }
                            }

                            Process {
                                id: caffieneToggleProc
                                command: ["/home/kaii/.config/quickshell/scripts/caffiene.sh", "toggle"]

                                running: false

                                stdout: StdioCollector {
                                    onStreamFinished: {
                                        caffieneCheckProc.running = true
                                    }
                                }
                            }

                            QsTile {
                                id: caffieneTile
                                title: "Caffiene"
                                summary: "Inactive"
                                iconPath: "/home/kaii/.config/quickshell/assets/caffiene.svg"
                                active: caffieneTile.summary == "Active"
                                command: function() {
                                    caffieneToggleProc.running = true
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

                        WrapperItem {
                            topMargin: 16
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 1

                            ColumnLayout {
                                spacing: 16

                                PwObjectTracker {
                                    objects: [ Pipewire.defaultAudioSink ]
                                }

                                Process {
                                    command: ["echo", "hi"]
                                    running: true

                                    stdout: StdioCollector {
                                        onStreamFinished: {
                                            volumeConnection.onVolumeChanged()
                                            brightnessConnection.onStateChanged()
                                        }
                                    }
                                }

                                Connections {
                                    id: volumeConnection
                                    target: Pipewire.defaultAudioSink?.audio ?? null

                                    function onVolumeChanged() {
                                        if (!Pipewire.defaultAudioSink.ready) return

                                        var volume = (Pipewire.defaultAudioSink?.audio.volume * 100) ?? 0
                                        var icon = "/home/kaii/.config/quickshell/assets/volume_mute.svg"
                                        
                                        if (volume == 0) {
                                            icon = "/home/kaii/.config/quickshell/assets/volume_mute.svg"
                                        } else if (volume < 33) {
                                            icon = "/home/kaii/.config/quickshell/assets/volume_low.svg"
                                        } else if (volume < 67) {
                                            icon = "/home/kaii/.config/quickshell/assets/volume_mid.svg"
                                        } else {
                                            icon = "/home/kaii/.config/quickshell/assets/volume_high.svg"
                                        }

                                        volumeSlider.value = volume
                                        volumeSlider.icon = icon
                                    }
                                }

                                MaterialSlider {
                                    id: volumeSlider

                                    icon: "/home/kaii/.config/quickshell/assets/volume_mid.svg"
                                    iconSize: 34
                                    paddingLeft: 0.5
                                    paddingTop: 1
                                    value: 0

                                    onSlide: function(value) {
                                        if (Pipewire.defaultAudioSink?.audio) {
                                            Pipewire.defaultAudioSink.audio.volume = value / 100
                                        }
                                    }
                                }

                                Connections {
                                    id: brightnessConnection
                                    target: BrightnessState

                                    function onStateChanged() {
                                        var jsonData = JSON.parse(BrightnessState.state)
                                        brightnessSlider.value = jsonData.level
                                        brightnessSlider.icon = jsonData.icon
                                    }
                                }

                                MaterialSlider {
                                    id: brightnessSlider

                                    icon: "/home/kaii/.config/quickshell/assets/brightness_2.svg"
                                    iconSize: 24
                                    paddingLeft: 5.5
                                    paddingTop: 9.5
                                    value: 0

                                    onSlide: function(value) {
                                        BrightnessState.setBrightness(value)
                                    }
                                }
                            }
                        }

                        WrapperItem {
                            topMargin: 16
                            Layout.fillWidth: true
                            
                            MediaPlayer {}
                        }
                    }
                }
            }
        }
    }
}