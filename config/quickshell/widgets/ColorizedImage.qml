import "root:/config"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

Item {
    id: root
    required property string source
    required property var color
    required property int size

    height: 36
    width: 36

    ColorOverlay {
        anchors.fill: image
        source: image
        color: root.color
    }

    IconImage {
        id: image
        source: Qt.resolvedUrl(root.source)
        implicitSize: root.size
        smooth: true
        visible: false
    }
}