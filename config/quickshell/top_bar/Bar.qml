//@ pragma UseQApplication

import "root:/config"
import "root:/osds"
import "root:/widgets"
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Wayland

Scope {
  id: root
  
  Quicksettings {
      id: quicksettingsMenu
      activePlayer: Mpris.players.values[1]
  }

  // stolen from https://github.com/end-4/dots-hyprland/blob/968e8195efacc916b85bd766fe878229d8859af2/.config/quickshell/ii/services/MprisController.qml#L27
  Instantiator {
		model: Mpris.players;

		Connections {
			required property MprisPlayer modelData;
			target: modelData;

			Component.onCompleted: {
				if (quicksettingsMenu.activePlayer == null || modelData.isPlaying) {
					quicksettingsMenu.activePlayer = modelData;
				}
			}

			Component.onDestruction: {
				if (quicksettingsMenu.activePlayer == null || !quicksettingsMenu.activePlayer.isPlaying) {
					for (const player of Mpris.players.values) {
						if (player.playbackState.isPlaying) {
							quicksettingsMenu.activePlayer = player;
							break;
						}
					}

					if (activePlayer == null && Mpris.players.values.length != 0) {
						activePlayer = Mpris.players.values[0];
					}
				}
			}

			function onPlaybackStateChanged() {
				if (quicksettingsMenu.activePlayer !== modelData) quicksettingsMenu.activePlayer = modelData;
			}
		}
	}

  VolumeBrightnessOSD {
    quicksettingsMenu: quicksettingsMenu
  }

  PanelWindow {
  	id: barRoot
    anchors {
      top: true
      left: true
      right: true
    }

    WlrLayershell.layer: WlrLayer.Top

    implicitHeight: Appearance.sizes.barHeight
    color: Appearance.colors.primaryText

      RowLayout {
      	anchors.fill: parent
      	anchors.centerIn: parent

        Rectangle {
          width: 10
        }

        RowLayout {
          spacing: Appearance.spacing.large

          DashboardButton {}
          CpuTemp {}
          LanguageIndicator {}
        }

        Rectangle {
          Layout.fillWidth: true
        }

        RowLayout {
          spacing: Appearance.spacing.large

          SystemTray {}
          ClockWidget {}
          NotificationButton {}
          QuickSettingsButton {
            quicksettingsMenu: quicksettingsMenu
          }
          BatteryIndicator {}
          PowerButton {}
        }

        Rectangle {
          width: 10
        }
      }

      // outside of the row just to center it
      Workspaces {
        id: workspacesWidget
        Layout.fillHeight: true
        implicitWidth: 400
        implicitHeight: Appearance.sizes.height
        anchors.centerIn: parent
      }
  }

  component Popout: Loader {
        id: popout

        required property string name
        property bool shouldBeActive: root.currentName === name

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right

        opacity: 0
        scale: 0.8
        active: false
        asynchronous: true

        states: State {
            name: "active"
            when: popout.shouldBeActive

            PropertyChanges {
                popout.active: true
                popout.opacity: 1
                popout.scale: 1
            }
        }

        transitions: [
            Transition {
                from: "active"
                to: ""

                SequentialAnimation {
                    // Anim {
                    //     properties: "opacity,scale"
                    //     duration: Appearance.anim.durations.small
                    // }
                    PropertyAction {
                        target: popout
                        property: "active"
                    }
                }
            },
            Transition {
                from: ""
                to: "active"

                SequentialAnimation {
                    PropertyAction {
                        target: popout
                        property: "active"
                    }
                    // Anim {
                    //     properties: "opacity,scale"
                    // }
                }
            }
        ]
    }
}

