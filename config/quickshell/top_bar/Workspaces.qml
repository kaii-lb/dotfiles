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
    	width: workspacesRow.width * 1.2
    	height: Appearance.sizes.height // or 0 maybe? it also looks good
    	anchors.centerIn: workspacesRow
    }

    Row {
    	id: workspacesRow
        spacing: 8
        anchors {
		    horizontalCenter: parent.horizontalCenter
		    verticalCenter: parent.verticalCenter
		}

        Repeater {
        	id: workspacesRepeater
            model: Hyprland.workspaces

            Workspace {}
        }
    }
}
