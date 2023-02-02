ismuted=$(pamixer --get-mute)

if [ "$ismuted" = false ]; then
	pamixer --mute 
else
	pamixer --unmute
fi

# ismuted=$(pactl get-sink-mute @DEFAULT_SINK@)

#sh ~/.config/hypr/scripts/restart_waybar

# notify-send "$ismuted" "" --icon=dialog-information
