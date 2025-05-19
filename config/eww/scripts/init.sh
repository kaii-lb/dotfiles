#!/bin/sh

./get_battery_icon.sh
./get_brightness_icon.sh
./get_network_icon.sh
./get_volume_icon.sh
./set_current_language.sh

eww open topbar
