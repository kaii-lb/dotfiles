import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets 
import "root:/config"
import "root:/utils"
import "root:/widgets"

Item {
    id: root

    required property var quicksettingsMenu
    property bool isPowered: false

    clip: true
    implicitHeight: Appearance.sizes.height
    implicitWidth: quicksettingsRow.width * 1.2

    Behavior on implicitWidth {
        animation: Appearance.animations.elementMoveEnter.numberAnimation.createObject(this)
    }

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
        }
        ListElement {
            iconSource: "/home/kaii/.config/quickshell/assets/volume_mute.svg"
            iconSize: 35
            isBluetooth: false
            marginLeft: -4
        }
        ListElement {
            iconSource: "/home/kaii/.config/quickshell/assets/brightness_2.svg"
            iconSize: 25
            isBluetooth: false
            marginLeft: 0
        }
    }

    RowLayout {
        id: quicksettingsRow
        spacing: 4
        anchors.centerIn: parent

        Repeater {
            model: elementModel

            WrapperItem {
                leftMargin: marginLeft
                
                IconImage {
                    width: 20
                    source: Qt.resolvedUrl(iconSource)
                    implicitSize: iconSize
                }
            }
        }
    }

	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

    // here so we can call it on startup
    function onVolumeChange() {
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

        var index = elementModel.get(1).isBluetooth ? 2 : 1

        elementModel.setProperty(index, "iconSource", icon)
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio ?? null

        function onVolumeChanged() {
            root.onVolumeChange()
        }
    }

    Connections {
        target: NetworkState

        function onStateChanged() {
            var jsonData = JSON.parse(NetworkState.state)

            elementModel.setProperty(0, "iconSource", jsonData.icon)
        }
    }
    
    Connections {
        target: BrightnessState

        function onStateChanged() {
            root.onVolumeChange()
            var jsonData = JSON.parse(BrightnessState.state)
            var index = elementModel.get(1).isBluetooth ? 3 : 2

            elementModel.setProperty(index, "iconSource", jsonData.icon)
        }
    }

    Connections {
        target: BluetoothState

        function onStateChanged() {
            var jsonData = JSON.parse(BluetoothState.state)
            root.isPowered = jsonData.powered === "true"
            
            var index = elementModel.get(1).isBluetooth ? 2 : 1
            var marginLeft = root.isPowered ? -4 : 0
            elementModel.setProperty(index, "marginLeft", marginLeft)

            if (isPowered) {
                elementModel.get(1).isBluetooth ? elementModel.setProperty(1, "iconSource", jsonData.icon) : elementModel.insert(1, { iconSource: jsonData.icon, iconSize: 25, isBluetooth: true, marginLeft: 0, marginRight: 0 })
            } else {
                elementModel.get(1).isBluetooth ? elementModel.remove(1, 1) : elementModel.get(1)
            }
        }
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton
        anchors.fill: parent
        id: quicksettingsMouseArea

        onClicked: quicksettingsMenu.shouldShowQuicksettings = !quicksettingsMenu.shouldShowQuicksettings
    }
}
