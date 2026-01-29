import "root:/config"
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Widgets
import QtQuick.Controls

Rectangle {
    id: powerButton

    implicitWidth: cpuTempRow.width * 1.2
    implicitHeight: Appearance.sizes.height
    color: Appearance.colors.surface
    radius: Appearance.radii.normal

    Row {
        id: cpuTempRow
        anchors.centerIn: parent
        rightPadding: 8

        IconImage {
            implicitSize: Appearance.sizes.icon
            source: Qt.resolvedUrl("/home/kaii/.config/quickshell/assets/temp.svg")
        }

        Rectangle {
            width: 2
            height: Appearance.sizes.icon
            color: "transparent"
        }


        WrapperItem {
            implicitHeight: parent.height
            topMargin: 2

            Text {
                id: temp
                color: Appearance.colors.text

                font.bold: true
                font.pixelSize: Appearance.sizes.barFontSize

                Process {
                    id: tempProc
                    command: ["sh", "-c", "~/.config/quickshell/scripts/get_temp.sh"]

                    running: true

                    stdout: StdioCollector {
                        onStreamFinished: temp.text = this.text
                    }
                }

                Timer {
                    interval: 3000
                    running: true
                    repeat: true
                    onTriggered: tempProc.running = true
                }
            }
        }

        WrapperItem {
            implicitHeight: Appearance.sizes.icon
            topMargin: 3
        
            Text {
                text: "°C"
                color: Appearance.colors.text

                font.bold: true
                font.pixelSize: Appearance.sizes.barFontSize

                anchors.centerIn: parent
            }
        }
    }
}
