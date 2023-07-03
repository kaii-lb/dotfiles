#!/bin/sh

if [[ $1 == "increase" ]]; then
	ismuted=$(pamixer --get-mute)

	if [ "$ismuted" = true ]; then
		pamixer --unmute 
	fi

	if [[ -z $2 ]]; then
		pamixer -i 5
	else
		pamixer -i $2
	fi
	
	canberra-gtk-play -i audio-volume-change -d "changeVolume"

	echo increased
	exit 0
elif [[ $1 == "decrease" ]]; then
	ismuted=$(pamixer --get-mute)

	if [ "$ismuted" = true ]; then
			pamixer --unmute
	fi

	if [[ -z $2 ]]; then
		pamixer -d 5
	else	
		pamixer -d $2
	fi
	
	canberra-gtk-play -i audio-volume-change -d "changeVolume"

	echo decreased
	exit 0
elif [[ $1 == "toggle-mute" ]]; then
	ismuted=$(pamixer --get-mute)

	if [ "$ismuted" = false ]; then
		rm $HOME/.config/hypr/scripts/current_volume.txt
		echo $(pamixer --get-volume > $HOME/.config/hypr/scripts/current_volume.txt)
		pamixer -t
		pamixer pamixer --set-volume 0 
	else
		current_volume=$(cat $HOME/.config/hypr/scripts/current_volume.txt)
		pamixer --set-volume $current_volume
		pamixer -t
	fi

	echo toggled mute
	exit 0
else
	echo -e "Usage: volume [option] [value]"
	echo -e "\nOptions: "
	echo -e "\n    increase: increases the volume by specified value (5% if no value is provided)"
	echo -e "\n    decrease: decreases the volume by specified value (5% if no value is provided)"
	echo -e "\n    toggle-mute: ...toggles muting, pretty self explanatory"
fi
