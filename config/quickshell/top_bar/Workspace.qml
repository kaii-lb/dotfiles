import "root:/config"
import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: workspaceRoot

    required property var modelData
    property bool active: Hyprland.focusedMonitor.activeWorkspace.id === workspaceRoot.modelData.id

	width: active ? 42 : 22
    height: 22

    Rectangle {
        id: indicator

        color: active ? Appearance.colors.primary : Appearance.colors.surfacePressed

        width: active ? 42 : 22
        height: 22
        radius: Appearance.radii.large

        anchors.centerIn: parent

        MouseArea {
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspace " + workspaceRoot.modelData.id)
        }
    }
}
