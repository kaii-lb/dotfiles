pragma ComponentBehavior: Bound

import "root:/config"
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: itemRoot

    Rectangle {
    	radius: Appearance.radii.normal
    	color: Appearance.colors.surface
    	width: workspacesRow.width
    	height: Appearance.sizes.height // or 0 maybe? it also looks good
    	anchors.centerIn: workspacesRow
    }

    Row {
    	id: workspacesRow
        spacing: 6
        anchors {
		    horizontalCenter: parent.horizontalCenter
		    verticalCenter: parent.verticalCenter
		}
		leftPadding: 12
		rightPadding: 12

        Repeater {
        	id: workspacesRepeater
            model: Hyprland.workspaces

            Workspace {}
        }
    }
}
