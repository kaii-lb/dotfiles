#!/bin/sh

eww daemon

eww open topbar
eww open notification-view
eww open volumeosd
eww open brightnessosd

/home/kaii/.config/eww/scripts/get_brightness_icon.sh
/home/kaii/.config/eww/scripts/get_network_icon.sh
/home/kaii/.config/eww/scripts/get_volume_icon.sh
/home/kaii/.config/eww/scripts/set_current_language.sh

perf_state=$(/home/kaii/.config/eww/scripts/performance_modes.sh state)

if [[ $perf_state == "on" ]]; then
	eww update performance_mode=true
else
	eww update performance_mode=false
fi

/home/kaii/.config/eww/scripts/notifications.sh getdnd

python3 /home/kaii/.config/eww/scripts/notification_daemon.py & disown
