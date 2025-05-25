#!/bin/sh

if eww active-windows | grep quicksettings-menu &>/dev/null; then
	eww close quicksettings-menu && eww close quicksettings-menu-closer
else
	eww open quicksettings-menu && eww open quicksettings-menu-closer
fi
