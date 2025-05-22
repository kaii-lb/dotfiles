#!/bin/sh

brightness=$(brightnessctl i | grep Current | cut -f4 -d' ' | sed -e "s/(//g" -e "s/%)//g")

echo $brightness >> /tmp/current_brightness

if [[ $brightness -lt 20 ]]; then
	echo "/home/kaii/.config/eww/assets/brightness_1.svg" >> /tmp/current_brightness_icon
elif [[ $brightness -lt 40 ]]; then
	echo "/home/kaii/.config/eww/assets/brightness_2.svg" >> /tmp/current_brightness_icon
elif [[ $brightness -lt 60 ]]; then
	echo "/home/kaii/.config/eww/assets/brightness_3.svg" >> /tmp/current_brightness_icon
elif [[ $brightness -lt 80 ]]; then
	echo "/home/kaii/.config/eww/assets/brightness_4.svg" >> /tmp/current_brightness_icon
else
	echo "/home/kaii/.config/eww/assets/brightness_5.svg" >> /tmp/current_brightness_icon
fi

eww update open_volume_osd=false
eww update open_brightness_osd=true

sleep 3
eww_brightness=$(eww get brightness)
if [[ $eww_brightness -eq $brightness ]]; then
	eww update open_brightness_osd=false
fi
