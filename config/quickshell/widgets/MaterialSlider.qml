import "root:/config"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

WrapperItem {
    id: root
    required property string icon
    required property var onSlide
    required property int iconSize
    required property double paddingLeft
    required property double paddingTop
    required property int value

    Layout.fillWidth: true
    Layout.horizontalStretchFactor: 1

    implicitHeight: 35

    leftMargin: 4
    rightMargin: 4

    RowLayout {
        WrapperRectangle {
            implicitHeight: root.implicitHeight
            implicitWidth: root.implicitHeight

            leftMargin: root.paddingLeft
            rightMargin: root.paddingLeft

            radius: Appearance.radii.full
            color: Appearance.colors.primary
        
            WrapperItem {
                topMargin: root.paddingTop

                ColorizedImage {
                    source: Qt.resolvedUrl(root.icon)
                    size: root.iconSize
                    color: Appearance.colors.primaryText

                    anchors.centerIn: parent
                }
            }
        }

        Slider {
            id: control
            from: 0
            to: 100

            value: root.value

            Layout.fillWidth: true
            Layout.horizontalStretchFactor: 1

            implicitHeight: root.implicitHeight

            onMoved: root.onSlide(control.value)

            background: Rectangle {
                x: control.leftPadding
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: control.availableHeight


                width: control.availableWidth
                radius: Appearance.radii.full
                color: Appearance.colors.surfacePressed

                Rectangle {
                    width: control.visualPosition * parent.width
                    height: parent.height
                    color: Appearance.colors.primary
                    radius: Appearance.radii.full
                }
            }

            handle: Rectangle {
                implicitWidth: 0
                implicitHeight: 0
                color: "transparent"
                border.color: "transparent"
            }
        }
    }
}