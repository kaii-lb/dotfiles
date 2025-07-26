import "root:/config"
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Widgets
import QtQuick.Controls

Rectangle {
    implicitWidth: Appearance.sizes.height * 1.25
    implicitHeight: Appearance.sizes.height
    color: Appearance.colors.surface
    radius: Appearance.radii.normal

    Text {
        id: languageIndicatorText
        color: Appearance.colors.text

        font.bold: true
        font.pixelSize: 18

        anchors.centerIn: parent

        Process {
            id: langProc
            command: ["tail", "-F", "/tmp/current_language"]

            running: true

            stdout: SplitParser {
                onRead: data => {
                    languageIndicatorText.text = data
                }
            }
        }
    }
}