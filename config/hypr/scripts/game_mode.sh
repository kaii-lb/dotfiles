#!/bin/sh

is_in_performance_mode=$()

if systemctl status thermald.service | grep -q running; then
	notify-send "Gaming Mode Disabled" "No longer frying your hardware"

	hyprctl keyword decoration:shadow:enabled true
	hyprctl keyword decoration:blur:enabled true
	pkexec systemctl stop thermald.service
else
	notify-send "Gaming Mode Enabled" "Built-In toaster activated wooooh!"

	hyprctl keyword decoration:shadow:enabled false
	hyprctl keyword decoration:blur:enabled false
	pkexec sh -c 'systemctl start thermald.service; sed -i -e 's/PowerSave/Gaming/g' /etc/scx_loader.toml; systemctl restart scx_loader.service'
fi
