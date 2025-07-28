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
        id: networkProc
        command: ["/home/kaii/.config/quickshell/scripts/network_state.sh"]

        running: true

        stdout: SplitParser {
            onRead: data => {
                root.state = data
            }
        }
    }
}