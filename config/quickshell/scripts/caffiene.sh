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
	else
		python3 ~/.config/quickshell/scripts/idleinhibit.py & disown
	fi
}

case $1 in
	"check")
		check ;;
	"toggle")
		toggle ;;
esac
