#!/bin/sh

state() {
	if systemctl status thermald.service | grep -q running; then
		echo on
	else
		echo off
	fi
}

switch() {
	current=$(state)

	if [[ $current == "on" ]]; then
		pkexec systemctl stop thermald.service &&
		hyprctl keyword decoration:shadow:enabled true &&
		hyprctl keyword decoration:blur:enabled true &&
		eww update performance_mode=false
	else
		pkexec sh -c 'systemctl start thermald.service; sed -i -e 's/PowerSave/Gaming/g' /etc/scx_loader.toml; systemctl restart scx_loader.service' &&
		hyprctl keyword decoration:shadow:enabled false &&
		hyprctl keyword decoration:blur:enabled false &&
		eww update performance_mode=true
	fi
}

case $1 in
	"switch")
		switch ;;
	"state")
		state ;;
	*)
		echo "command $1 doesn't exist" ;;
esac
