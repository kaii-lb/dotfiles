#!/bin/sh

brightness=$(brightnessctl i | grep Current | cut -f4 -d' ' | sed -e "s/(//g" -e "s/%)//g")

if [[ $brightness -lt 20 ]]; then
	echo "/home/kaii/.config/eww/assets/brightness_1.svg" >> /tmp/current_brightness
elif [[ $brightness -lt 40 ]]; then
	echo "/home/kaii/.config/eww/assets/brightness_2.svg" >> /tmp/current_brightness
elif [[ $brightness -lt 60 ]]; then
	echo "/home/kaii/.config/eww/assets/brightness_3.svg" >> /tmp/current_brightness
elif [[ $brightness -lt 80 ]]; then
	echo "/home/kaii/.config/eww/assets/brightness_4.svg" >> /tmp/current_brightness
else
	echo "/home/kaii/.config/eww/assets/brightness_5.svg" >> /tmp/current_brightness
fi
