import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import "root:/config"

Button {
    id: powerButton

    icon.source: "/home/kaii/.config/quickshell/assets/power.svg"
    icon.color: Appearance.colors.primaryText
    icon.width: 25
    icon.height: 25

    background: Rectangle {
        implicitWidth: Appearance.sizes.height
        implicitHeight: Appearance.sizes.height
        color: powerButton.down ? Appearance.colors.primaryPressed : Appearance.colors.primary
        radius: Appearance.radii.large
    }

    Process {
        id: powerMenuProc
        command: ["sh", "/home/kaii/.config/rofi/bin/powermenu"]

        running: false
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent 
        acceptedButtons: Qt.NoButton
    }

    onClicked: powerMenuProc.running = true
}