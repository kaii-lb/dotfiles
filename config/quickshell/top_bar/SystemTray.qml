import "root:/config"
import Quickshell.Services.SystemTray
import QtQuick

Item {
    id: root

    readonly property Repeater items: items

    clip: false
    visible: width > 0 && height > 0 // To avoid warnings about being visible with no size

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    Row {
        id: layout

        spacing: Appearance.spacing.normal

        add: Appearance.animations.elementMoveEnter.numberAnimation.createObject(this)

        move: Appearance.animations.elementMoveEnter.numberAnimation.createObject(this)

        Repeater {
            id: items

            model: SystemTray.items

            TrayItem {}
        }
    }

    Behavior on implicitWidth {
        animation: Appearance.animations.elementMoveEnter.numberAnimation.createObject(this)
    }

    Behavior on implicitHeight {
        animation: Appearance.animations.elementMoveEnter.numberAnimation.createObject(this)
    }
}