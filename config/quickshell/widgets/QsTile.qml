import "root:/config"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

WrapperRectangle {
    id: root
    required property bool active
    required property string title
    required property string summary
    required property string iconPath
    required property var command

    property bool hasExtra: false
    property string secondCommand: ""

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.horizontalStretchFactor: 1

    color: active ? Appearance.colors.primary : Appearance.colors.surfacePressed
    radius: Appearance.radii.full
    margin: 16

    Behavior on color {
        animation: Appearance.animations.elementMoveFast.colorAnimation.createObject(this)
    }

    WrapperMouseArea {
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onClicked: root.command()

        RowLayout {
            id: rowLayout
            spacing: 10

            ColorizedImage {
                source: root.iconPath
                color: Appearance.colors.primaryText
                size: 36
            }

            ColumnLayout {
                spacing: 0
                Layout.maximumWidth: 10 // hack
                
                Text {
                    text: title
                    color: Appearance.colors.primaryText
                    font.pointSize: 16
                    font.weight: Font.Bold
                }

                Text {
                    text: summary
                    color: Appearance.colors.primaryText
                    font.pointSize: 12
                }
            }

            Rectangle {
                Layout.fillWidth: true

                ColorizedImage {
                    visible: root.hasExtra
                    source: "/home/kaii/.config/quickshell/assets/arrow_right.svg"
                    color: Appearance.colors.primaryText
                    size: 36
                    
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                    }

                    Process {
                        id: secondaryProc
                        command: ["sh", "-c", root.secondCommand]

                        running: false
                    }

                    MouseArea {
                        visible: root.hasExtra
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.LeftButton
                        anchors.fill: parent

                        onClicked: secondaryProc.running = true
                    }
                }
            }
        }
    }
}