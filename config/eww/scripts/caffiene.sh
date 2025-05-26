#!/bin/sh

pid=$(ps aux | grep "[i]dleinhibit.py" | awk '{print $2}')

if [[ $pid != "" ]]; then
	kill $pid
	eww update caffiene=false
else
	python3 ~/.config/eww/scripts/idleinhibit.py & disown
	eww update caffiene=true
fi
