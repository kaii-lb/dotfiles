import Quickshell
import QtQuick
import Quickshell.Widgets
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

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        acceptedButtons: Qt.NoButton 
    }
}