import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import "root:/config"

Button {
    id: notificationButton

    required property var notificationShade
    required property var quicksettingsMenu

    icon.source: "/home/kaii/.config/quickshell/assets/notifications_filled.svg"
    icon.color: Appearance.colors.text
    icon.width: 25
    icon.height: 25

    Behavior on implicitWidth {
        animation: Appearance.animations.elementMoveEnter.numberAnimation.createObject(this)
    }

    background: Rectangle {
        implicitWidth: Appearance.sizes.height
        implicitHeight: 42
        radius: Appearance.radii.normal
        
        color: notificationMouseArea.pressedButtons & Qt.LeftButton ? Appearance.colors.surfacePressed : Appearance.colors.surface
    }

    MouseArea {
        id: notificationMouseArea
        anchors.fill: parent
        
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onClicked: function() {
            notificationShade.showNotificationShade = !notificationShade.showNotificationShade
            quicksettingsMenu.shouldShowQuicksettings = false
        }
    }
}