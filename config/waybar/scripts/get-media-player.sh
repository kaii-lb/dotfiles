#!/bin/sh

player=$(playerctl --player=io,com,spotify,firefox,%any metadata --format '{{playerName}}')

if [[ $player =~ "io" ]]; then
	player_name=amberol
elif [[ $player =~ "com" ]]; then
	player_name=g4music
else
	player_name=$player
fi

is_running=$(pgrep $player_name > /dev/null && echo 0)

if [[ $is_running -eq 0 ]];then
	id=$(hyprctl clients -j | jq -r '.[] | select(.class == "io.bassi.Amberol").workspace["id"]')
	class=$(hyprctl clients -j | jq -r '.[] | select(.class == "io.bassi.Amberol").class')
	hyprctl dispatch workspace $id && echo "Moved to ${id}"
	hyprctl dispatch focuswindow $class && echo "Focused ${class}"
	#hyprctl dispatch focuswindow "io.bassi.Amberol"
else
	$player_name
fi

#exec $player_name

