import "root:/config"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

WrapperRectangle {
    id: root
    required property var closeFunction

    implicitHeight: quicksettingsHeaderBar.implicitHeight
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter + Qt.AlignTop
    color: "transparent"

    RowLayout {
        id: quicksettingsHeaderBar
        spacing: 16

        ClippingRectangle {
            radius: Appearance.radii.full
            Layout.preferredWidth: 64
            Layout.preferredHeight: 64
        
            IconImage {
                source: Qt.resolvedUrl("/home/kaii/.face")
                implicitSize: parent.height
            }
        }

        Text {
            text: "kaii | Hyprland"
            color: Appearance.colors.text
            font.pointSize: 18
            font.weight: Font.Bold
            Layout.fillWidth: true
        }

        MouseArea {
            id: quicksettingsHeaderBarExitMouseArea
            width: 36
            height: 36

            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton

            onClicked: root.closeFunction()

            Rectangle {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                color: quicksettingsHeaderBarExitMouseArea.pressed ? Appearance.colors.surfacePressed : Appearance.colors.surfaceDark
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