#!/bin/sh

if systemctl status thermald.service | grep -q running; then
	notify-send "Gaming Mode Disabled" "No longer frying your hardware"

	pkexec sh -c 'systemctl stop thermald.service; systemctl stop lactd; sysctl kernel.split_lock_mitigate=1' &&
	hyprctl keyword decoration:shadow:enabled true &&
	hyprctl keyword decoration:blur:enabled true &&
	eww update performance_mode=false
else
	notify-send "Gaming Mode Enabled" "Built-In toaster activated wooooh!"

	pkexec sh -c 'systemctl start thermald.service; systemctl start lactd; sysctl kernel.split_lock_mitigate=0; #sed -i -e 's/PowerSave/Gaming/g' /etc/scx_loader.toml; # systemctl restart scx_loader.service' &&
	hyprctl keyword decoration:shadow:enabled false &&
	hyprctl keyword decoration:blur:enabled false &&
	eww update performance_mode=true
fi
