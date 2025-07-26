import "root:/config"
import Quickshell.Services.SystemTray
import QtQuick

Item {
    id: root

    readonly property Repeater items: items

    clip: true
    visible: width > 0 && height > 0 // To avoid warnings about being visible with no size

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    Row {
        id: layout

        spacing: Appearance.spacing.normal

        add: Transition {
            NumberAnimation {
                properties: "scale"
                from: 0
                to: 1
                duration: Appearance.animations.durationNormal
                easing.type: Easing.BezierSpline
            }
        }

        move: Transition {
            NumberAnimation {
                properties: "scale"
                to: 1
                duration: Appearance.animations.durationNormal
                easing.type: Easing.BezierSpline
            }
            NumberAnimation {
                properties: "x,y"
                duration: Appearance.animations.durationNormal
                easing.type: Easing.BezierSpline
            }
        }

        Repeater {
            id: items

            model: SystemTray.items

            TrayItem {}
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Appearance.animations.durationNormal
            easing.type: Easing.BezierSpline
        }
    }

    Behavior on implicitHeight {
        NumberAnimation {
            duration: Appearance.animations.durationNormal
            easing.type: Easing.BezierSpline
        }
    }
}