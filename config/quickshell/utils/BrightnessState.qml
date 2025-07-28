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
        id: brightnessProc
        command: ["tail", "-F", "/tmp/current_brightness"]

        running: true

        stdout: SplitParser {
            onRead: data => {
                root.state = data
            }
        }
    }
}
