import "root:/config"
import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
    radius: Appearance.radii.normal
    color: Appearance.colors.surface
    width: 172
    height: Appearance.sizes.height

    Text {
        anchors.centerIn: parent
        id: clock
        color: Appearance.colors.text

        font.bold: true
        font.pixelSize: Appearance.sizes.barFontSize

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