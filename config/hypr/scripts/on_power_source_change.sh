#!/bin/sh

export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-1
export XDG_RUNTIME_DIR=/run/user/1000

# echo "hello" > /home/kaii/TESTING.log

is_ac=$(systemd-ac-power -v)

echo Is on AC? $is_ac

if [[ $is_ac == "yes" ]]; then
	notify-send "On AC power" "Switching to performance mode"
	hyprctl keyword monitor eDP-1,1920x1080@144.00Hz,0x0,1,vrr,1
else
	notify-send "On battery power" "Switching to power saving mode"
	hyprctl keyword monitor eDP-1,1920x1080@60.00Hz,0x0,1,vrr,1
fi
