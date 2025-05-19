#!/bin/sh

battery_level=$(/home/kaii/.config/eww/scripts/get_battery_level.sh)
icon_number=$(printf %.0f\\n $(echo "scale=2; (98 + 0.5) / 12.5" | bc -l))

echo "/home/kaii/.config/eww/assets/battery-${icon_number}.svg"
