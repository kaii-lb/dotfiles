#!/bin/sh

path="$HOME/.config/hypr/scripts/power_saving_state.txt"

function toggle() {
	state=$(cat $path)
	if [[ $state == "on" ]]; then
		hyprctl keyword monitor eDP-1,1920x1080@144.00Hz,0x0,1,vrr,1 &>/dev/null
		power-daemon-mgr set-profile-override Performance++ &>/dev/null
		pkexec sh -c "ip link set enp7s0 up"
		echo off > $path
	else
		hyprctl keyword monitor eDP-1,1920x1080@60.00Hz,0x0,1,vrr,1 &>/dev/null
		power-daemon-mgr set-profile-override Powersave++ &>/dev/null
		pkexec sh -c "ip link set enp7s0 down"
		echo on > $path
	fi
}

function check() {
	sleep 0.1
	cat $path
}

case $1 in
	"check")
		check ;;
	"toggle")
		toggle ;;
esac
