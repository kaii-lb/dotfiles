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
        NumberAnimation {
            duration: 400
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [.38,.51,.34,1.45, 1, 1]
        }
    }

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 400
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [.38,.51,.34,1.45, 1, 1]
        }
    }
}