#!/bin/sh

/home/kaii/.config/eww/scripts/get_battery_icon.sh
/home/kaii/.config/eww/scripts/get_brightness_icon.sh
/home/kaii/.config/eww/scripts/get_network_icon.sh
/home/kaii/.config/eww/scripts/get_volume_icon.sh
/home/kaii/.config/eww/scripts/set_current_language.sh

eww daemon

python3 /home/kaii/.config/eww/scripts/notification_daemon.py & disown

eww open topbar
eww open notification-view
eww open volumeosd
eww open brightnessosd
