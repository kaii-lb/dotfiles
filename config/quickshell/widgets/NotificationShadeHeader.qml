import "root:/config"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

WrapperRectangle {
    id: root
    required property var closeFunction

    implicitHeight: notificationShadeHeaderBar.implicitHeight
    Layout.alignment: Qt.AlignHCenter + Qt.AlignTop
    color: "transparent"

    Process {
        id: clearNotifProc
        command: ["dunstctl", "history-clear"]

        running: false
    }

    RowLayout {
        id: notificationShadeHeaderBar
        spacing: 16
        Layout.fillWidth: true

        Text {
            text: "Notifications"
            color: Appearance.colors.text
            font.pointSize: Appearance.sizes.barFontSize
            font.weight: Font.Bold
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
        }

        MouseArea {
            id: clearMouseArea
            width: 36
            height: 36

            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton
            hoverEnabled: true

            onClicked: function() {
                clearNotifProc.running = true
            }

            Rectangle {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                color: clearMouseArea.containsMouse ? clearMouseArea.pressed ? Appearance.colors.surfaceDark : Appearance.colors.surfacePressed : "transparent"
                radius: Appearance.radii.full
            }
            
            IconImage {
                source: Qt.resolvedUrl("/home/kaii/.config/quickshell/assets/clear_notifications.svg")
                implicitSize: 28
                anchors.centerIn: parent
            }
        }

        MouseArea {
            id: notificationShadeHeaderBarExitMouseArea
            width: 36
            height: 36

            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton

            onClicked: root.closeFunction()

            Rectangle {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                color: notificationShadeHeaderBarExitMouseArea.pressed ? Appearance.colors.surfacePressed : Appearance.colors.surfaceDark
                radius: Appearance.radii.full
            }
            
            IconImage {
                source: Qt.resolvedUrl("/home/kaii/.config/quickshell/assets/close.svg")
                implicitSize: 24
                anchors.centerIn: parent
            }
        }
    }
}