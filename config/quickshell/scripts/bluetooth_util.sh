#!/bin/sh

props=$(bluetoothctl show)
info=$(bluetoothctl info)

toggle() {
	powered=$(echo "${props}" | grep Powered | sed 's/Powered: //' | tr -d '["\t", " "]')

	if [[ $powered == "yes" ]]; then
		bluetoothctl power off
	else
		bluetoothctl power on
	fi
}

case "${1}" in
	"toggle")
		toggle ;;
	*)
		echo "command $1 not found"
esac

