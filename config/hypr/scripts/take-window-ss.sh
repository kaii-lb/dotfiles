#!/bin/sh
dir="$HOME/Pictures/Screenshots"
datetime=$(date +"%Y-%m-%d %I-%M-%S")

$HOME/.local/bin/grimblast --freeze copysave active  $dir/"Screenshot from ${datetime}".png

icon1="$HOME/.config/rofi/camera-viewfinder.svg"

dunstify -u low --replace=699 -i $icon1 "Copied to clipboard."
if [[ -e "$dir/Screenshot from ${datetime}.png" ]]; then
	dunstify -u low --replace=699 -i $icon1 "Screenshot Saved."
else
	dunstify -u low --replace=699 -i $icon1 "Screenshot Deleted."
fi
