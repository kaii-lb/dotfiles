import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import "root:/config"

Button {
    id: notificationButton

    icon.source: "/home/kaii/.config/quickshell/assets/arch.svg"
    icon.color: Appearance.colors.text
    icon.width: Appearance.sizes.height / 2
    icon.height: Appearance.sizes.height / 2

    background: Rectangle {
        implicitWidth: Appearance.sizes.height
        implicitHeight: Appearance.sizes.height
        color: notificationButton.down ? Appearance.colors.surfacePressed : Appearance.colors.surface
        radius: Appearance.radii.large
    }

    Process {
        id: dashboardProc
        command: ["sh", "/home/kaii/.config/rofi/bin/launcher"]

        running: false
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        
        onClicked: dashboardProc.running = true
    }
}