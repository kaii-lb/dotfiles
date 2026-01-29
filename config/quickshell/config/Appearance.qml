pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property Radii radii: Radii {}
    readonly property Colors colors: Colors {}
    readonly property Sizes sizes: Sizes {}
    readonly property Spacing spacing: Spacing {}
    readonly property Animations animations: Animations {}

    component Colors: QtObject {
        readonly property color primary: "#ACC7FF"
        readonly property color primaryPressed: "#ccddff"
        readonly property color primaryText: "#0F1417"
        readonly property color surface: "#1E333C"
        readonly property color surfaceDark: "#16262c"
        readonly property color surfacePressed: "#30515f"
        readonly property color text: "#ffffff"
        readonly property color textDim: "#cccccc"
    }

    component Radii: QtObject {
        readonly property int normal: 16
        readonly property int large: 32
        readonly property int full: 100
    }

    component Sizes: QtObject {
        readonly property int icon: 25
        readonly property int height: 40

        readonly property int workspaceIndicatorSizeUnfocused: 22
        readonly property int workspaceIndicatorSizeFocused: 42

        readonly property int barHeight: 60

        readonly property int barFontSize: 18
    }

    component Spacing: QtObject {
        readonly property int normal: 5
        readonly property int large: 10
    }

    component Animations: QtObject {
        readonly property int durationNormal: 400

        readonly property list<real> expressive: [.38,.51,.34,1.45, 1, 1]
        readonly property list<real> expressiveEffects: [0.34, 0.80, 0.34, 1.00, 1, 1]

        property QtObject elementMoveEnter: QtObject {
            property int duration: 400
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: root.animations.expressive
            property int velocity: 650
            
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animations.elementMoveEnter.duration
                    easing.type: root.animations.elementMoveEnter.type
                    easing.bezierCurve: root.animations.elementMoveEnter.bezierCurve
                }
            }
        }

        property QtObject elementMoveFast: QtObject {
            property int duration: 400
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: root.animations.expressiveEffects
            property int velocity: 850
            property Component colorAnimation: Component { ColorAnimation {
                duration: root.animations.elementMoveFast.duration
                easing.type: root.animations.elementMoveFast.type
                easing.bezierCurve: root.animations.elementMoveFast.bezierCurve
            }}
            property Component numberAnimation: Component { NumberAnimation {
                    duration: root.animations.elementMoveFast.duration
                    easing.type: root.animations.elementMoveFast.type
                    easing.bezierCurve: root.animations.elementMoveFast.bezierCurve
            }}
        }

        property QtObject elementMoveEnterFast: QtObject {
            property int duration: 180
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: root.animations.expressive
            property int velocity: 850
            
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animations.elementMoveEnterFast.duration
                    easing.type: root.animations.elementMoveEnterFast.type
                    easing.bezierCurve: root.animations.elementMoveEnterFast.bezierCurve
                }
            }
        }
    }
}

