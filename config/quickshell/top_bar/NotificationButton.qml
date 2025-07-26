import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import "root:/config"

Button {
    id: notificationButton

    icon.source: "/home/kaii/.config/eww/assets/notifications_filled.svg"
    icon.color: Appearance.colors.text
    icon.width: 25
    icon.height: 25

    background: Rectangle {
        implicitWidth: Appearance.sizes.height
        implicitHeight: 42
        color: notificationButton.down ? Appearance.colors.surfacePressed : Appearance.colors.surface
        radius: Appearance.radii.normal
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        acceptedButtons: Qt.NoButton 
    }
}