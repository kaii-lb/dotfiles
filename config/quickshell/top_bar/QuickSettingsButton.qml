import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets 
import "root:/config"

Item {
    id: root
    property bool isPowered: false
    property int marginBottom: 0
    clip: true

    implicitHeight: Appearance.sizes.height
    implicitWidth: quicksettingsRow.width * 1.2

    Rectangle {
        color: quicksettingsMouseArea.pressedButtons & Qt.LeftButton ? Appearance.colors.surfacePressed : Appearance.colors.surface
        radius: Appearance.radii.normal
        width: parent.width
        height: parent.height
    }

    ListModel {
        id: elementModel
        ListElement {
            iconSource: "/home/kaii/.config/quickshell/assets/wifi_connected.svg"
            iconSize: 25
            isBluetooth: false
            marginLeft: 0
            marginRight: 0
        }
        ListElement {
            iconSource: "/home/kaii/.config/quickshell/assets/volume_mute.svg"
            iconSize: 35
            isBluetooth: false
            marginLeft: -4
            marginRight: 0
        }
        ListElement {
            iconSource: "/home/kaii/.config/quickshell/assets/brightness_2.svg"
            iconSize: 25
            isBluetooth: false
            marginLeft: 0
            marginRight: 0
        }
    }

    RowLayout {
        id: quicksettingsRow
        spacing: 2
        anchors.centerIn: parent

        Repeater {
            model: elementModel

            WrapperItem {
                leftMargin: marginLeft
                rightMargin: marginRight
                bottomMargin: root.marginBottom

                IconImage {
                    width: 20
                    source: Qt.resolvedUrl(iconSource)
                    implicitSize: iconSize
                }
            }
        }
    }

    Process {
        id: bluetoothProc
        command: ["/home/kaii/.config/eww/scripts/bluetooth_state.sh"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var jsonData = JSON.parse(this.text)
                root.isPowered = jsonData.powered === "true"

                if (isPowered) {
                    elementModel.get(1).isBluetooth ? elementModel.setProperty(1, "iconSource", jsonData.icon) : elementModel.insert(1, { iconSource: jsonData.icon, iconSize: 25, isBluetooth: true, marginLeft: 0, marginRight: 0 })
                } else {
                    elementModel.get(1).isBluetooth ? elementModel.remove(1, 1) : elementModel.get(1)
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: bluetoothProc.running = true
    }

    Process {
        id: volumeProc
        command: ["tail", "-F", "/tmp/current_volume"]

        running: true

        stdout: SplitParser {
            onRead: data => {
                var jsonData = JSON.parse(data)
                var iconSize = jsonData.level > 67 ? 30 : 35
                var marginLeft = jsonData.level > 67 ? 0 : -3
                var marginRight = jsonData.level > 67 ? 2 : 0
                var index = elementModel.get(1).isBluetooth ? 2 : 1

                root.marginBottom = jsonData.level > 67 ? 2 : 0

                elementModel.setProperty(index, "iconSource", jsonData.icon)
                elementModel.setProperty(index, "iconSize", iconSize)
                elementModel.setProperty(index, "marginLeft", root.isPowered ? marginLeft : (jsonData.level > 67 ? 3 : 0))
                elementModel.setProperty(index, "marginRight", marginRight)
            }
        }
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton
        anchors.fill: parent
        id: quicksettingsMouseArea
    }
}