#!/bin/sh

battery_level=$(upower -d | grep percentage | tail -n1 | tr -d '['', 'percentage:', '%']')
icon_number=$(echo "scale=0; ($battery_level + 0.5) / 12.5" | bc)

echo "/home/kaii/.config/eww/assets/battery-${icon_number}.svg"
