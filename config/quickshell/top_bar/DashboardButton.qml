import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
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

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        acceptedButtons: Qt.NoButton 
    }
}