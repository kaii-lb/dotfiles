#!/bin/sh

pid=$(ps aux | grep "[i]dleinhibit.py" | awk '{print $2}')

check() {
	if [[ $pid != "" ]]; then
		echo true
	else
		echo false
	fi
}

toggle() {
	if [[ $pid != "" ]]; then
		kill $pid
		# eww update caffiene=false
	else
		python3 ~/.config/eww/scripts/idleinhibit.py & disown
		# eww update caffiene=true
	fi
}

case $1 in
	"check")
		check ;;
	"toggle")
		toggle ;;
esac
