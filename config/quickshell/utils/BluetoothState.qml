import "root:/config"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root
    property string state: ""
    
    Process {
        id: bluetoothProc
        command: ["/home/kaii/.config/quickshell/scripts/bluetooth_state.sh"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                state = this.text
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: bluetoothProc.running = true
    }
}