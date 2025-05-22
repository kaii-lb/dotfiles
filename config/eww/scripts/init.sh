#!/bin/sh

./get_battery_icon.sh
./get_brightness_icon.sh
./get_network_icon.sh
./get_volume_icon.sh
./set_current_language.sh

eww daemon

python3 ~/.config/eww/scripts/notification_daemon.py & disown

eww open topbar
eww open notification-view
eww open volumeosd
eww open brightnessosd
