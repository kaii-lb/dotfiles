import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import "root:/config"
import "root:/utils"

Rectangle {
    implicitWidth: batteryRow.width
    implicitHeight: Appearance.sizes.height
    color: Appearance.colors.surface
    radius: Appearance.radii.normal

    Row {
        id: batteryRow
        anchors.centerIn: parent
        spacing: -2

        leftPadding: 8
        rightPadding: 8

        IconImage {
            id: batteryIcon
            implicitSize: Appearance.sizes.icon
            source: Qt.resolvedUrl("/home/kaii/.config/quickshell/assets/battery-7.svg")
            rotation: -90
        }

        IconImage {
            id: batteryChargingIcon
            implicitSize: Appearance.sizes.icon
            source: Qt.resolvedUrl("/home/kaii/.config/quickshell/assets/battery_charging.svg")
        }

        Revealer {
            id: batteryLevelRevealer
            reveal: false

            Text {
                id: batteryText
                color: Appearance.colors.text

                font.bold: true
                font.pixelSize: 18

                leftPadding: 4
                rightPadding: 4
            }
        }


        Process {
            id: batteryProc
            command: ["/home/kaii/.config/quickshell/scripts/get_battery_state.sh"]

            running: true

            stdout: SplitParser {
                onRead: data => {
                    var jsonData = JSON.parse(data)
                    batteryIcon.source = Qt.resolvedUrl(jsonData.icon)
                    batteryText.text = jsonData.level + "%"
                    batteryChargingIcon.visible = jsonData.state === "charging" ? true : false
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton 

        hoverEnabled: true
        onEntered: batteryLevelRevealer.reveal = true
        onExited: batteryLevelRevealer.reveal = false
    }
}
