#!/bin/sh

path="/usr/share/icons/hicolor/scalable/apps/"

if ! ls $path | grep $1; then
	echo "${path}org.gnome.Evolution-alarm-notify.svg"
else
	echo $path$possible
fi
