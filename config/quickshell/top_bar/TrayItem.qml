pragma ComponentBehavior: Bound

import "root:/config"
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

MouseArea {
    id: root

    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: Appearance.sizes.icon
    implicitHeight: Appearance.sizes.icon

    onClicked: event => {
        if (event.button === Qt.LeftButton)
            modelData.activate();
        else if (modelData.hasMenu)
            menu.open();
    }

    // TODO custom menu
    QsMenuAnchor {
        id: menu

        menu: root.modelData.menu
        anchor.edges: Edges.Bottom | Edges.Left
        anchor.item: parent
        anchor.margins.left: -100
    }

    IconImage {
        id: icon

        source: {
            let icon = root.modelData.icon;
            if (icon.includes("?path=")) {
                const [name, path] = icon.split("?path=");
                icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
            }
            return icon;
        }
        asynchronous: true
        anchors.fill: parent
    }
}