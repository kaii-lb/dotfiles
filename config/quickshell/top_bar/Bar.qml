//@ pragma UseQApplication

import "root:/config"
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Scope {
  id: root

  PanelWindow {
  	id: barRoot
    anchors {
      top: true
      left: true
      right: true
    }

    implicitHeight: 60
    color: "#0F1417"

      RowLayout {
      	anchors.fill: parent
      	anchors.centerIn: parent

        Rectangle {
          width: 10
        }

        RowLayout {
          spacing: 10

          DashboardButton {}
          CpuTemp {}
          LanguageIndicator {}
        }

        Rectangle {
          Layout.fillWidth: true
        }

        RowLayout {
          spacing: 10

          SystemTray {}
          ClockWidget {}
          NotificationButton {}
          QuickSettingsButton {}
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

