import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/config"
import "root:/utils"

Scope {
	id: root

	required property var quicksettingsMenu
    property string icon: "/home/kaii/.config/quickshell/assets/volume_mid.svg"
    property bool shouldShowOsd: false
    property double percent: 0.0

	// Bind the pipewire node so its volume will be tracked
	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

    Connections {
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

			root.percent = volume / 100
			root.icon = icon

            root.shouldShowOsd = true;
			hideTimer.restart();
        }
    }

	Timer {
		id: hideTimer
		interval: 3000
		onTriggered: root.shouldShowOsd = false
	}

	Connections {
        target: BrightnessState

        function onStateChanged() {
            var jsonData = JSON.parse(BrightnessState.state)

			root.percent = jsonData.level / 100;
			root.icon = jsonData.icon
			
			root.shouldShowOsd = true;
			hideTimer.restart();
        }
    }

	LazyLoader {
		active: root.shouldShowOsd && !quicksettingsMenu.shouldShowQuicksettings

		PanelWindow {
			exclusionMode: ExclusionMode.Ignore

			Component.onCompleted: {
				if (this.WlrLayershell != null) {
					this.WlrLayershell.layer = WlrLayer.Overlay;
				}
			}

			anchors.bottom: true
			margins.bottom: screen.height / 5

			implicitWidth: 400
			implicitHeight: 50
			color: "transparent"

			// An empty click mask prevents the window from blocking mouse events.
			mask: Region {}

			Rectangle {
				anchors.fill: parent
				radius: height / 2
				color: Appearance.colors.surface

				RowLayout {
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}

					IconImage {
						implicitSize: 30
						source: Qt.resolvedUrl(root.icon)
					}

					Rectangle {
						// Stretches to fill all left-over space
						Layout.fillWidth: true

						implicitHeight: 10
						radius: 20
						color: Appearance.colors.surfacePressed

						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
							}

							implicitWidth: parent.width * root.percent
							radius: parent.radius
						}
					}
				}
			}
		}
	}
}
