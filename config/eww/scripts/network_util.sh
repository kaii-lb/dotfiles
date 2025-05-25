#!/bin/sh

toggle() {
	enabled=$(nmcli radio wifi)

	if [[ $enabled == "enabled" ]]; then
		nmcli radio wifi off
	else
		nmcli radio wifi on
	fi
}

case "${1}" in
	"toggle")
		toggle ;;
	*)
		echo "command $1 not found"
esac
