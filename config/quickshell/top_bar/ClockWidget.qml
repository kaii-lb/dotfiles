import Quickshell
import QtQuick
import Quickshell.Io
import "root:/config"

Rectangle {
    radius: Appearance.radii.normal
    color: Appearance.colors.surface
    width: 180
    height: Appearance.sizes.height

    Text {
        anchors.centerIn: parent
        id: clock
        color: Appearance.colors.text

        font.bold: true
        font.pixelSize: 18

        Process {
            id: dateProc
            command: ["date", "+%a %d - %I:%M %p"]

            running: true

            stdout: StdioCollector {
                onStreamFinished: clock.text = this.text
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dateProc.running = true
        }
    }
}