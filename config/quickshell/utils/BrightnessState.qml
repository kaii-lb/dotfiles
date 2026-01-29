import "root:/config"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root
    property string state: ""
    property int percent: 0

    Process {
        id: brightnessProc
        command: ["tail", "-F", "/tmp/current_brightness"]

        running: true

        stdout: SplitParser {
            onRead: data => {
                root.state = data
            }
        }
    }

    Process {
        id: brightnessSetProc
        command: ["/home/kaii/.config/quickshell/scripts/get_brightness_icon.sh", "set", root.percent.toString() + "%"]

        running: false
    }

    function setBrightness(value: int) {
        root.percent = Math.max(1, value)
        brightnessSetProc.running = true
    }
}
