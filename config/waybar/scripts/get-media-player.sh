#!/bin/sh

player=$(playerctl --player=io,com,spotify,%any,firefox metadata --format '{{playerName}}')
class=""

if [[ $player =~ "io" ]]; then
	class=$(hyprctl clients -j | jq -r '.[] | select(.class | startswith("io")).class')
	player_name=$(echo $class | grep -oE '[^. ]+$' | awk '{print tolower($0)}')
elif [[ $player =~ "G4Music" ]]; then
	class=$(hyprctl clients -j | jq -r '.[] | select(.class | startswith("com")).class' | cut -f2 -d' ' | tail -n1)
	player_name=$(echo $class | grep -oE '[^. ]+$' | awk '{print tolower($0)}')
elif [[ $player =~ "mpd" ]]; then
	kitty ncmpcpp && exit 0
else
	class=$(hyprctl clients -j | jq --arg name $player -r '.[] | select(.class | ascii_downcase | startswith("$ARGS.named.name")).class')
	player_name=$player
fi

if [[ $player_name -eq "" ]]; then
	player=$(playerctl --player=io,com,spotify,%any,firefox metadata --format '{"player": "{{playerName}}" }')
	command=$(echo $player | jq -r '.[] | ascii_downcase')
	if [[ $command = "g4music" ]]; then
		flatpak run com.github.neithern.g4music
	else
		$command
	fi
	exit 0
fi

is_running=$(pgrep $player_name > /dev/null && echo 0)
echo "runnning "$is_running " name "$player_name " player "$player " class "$class

#echo "Player is: "$player

if [[ $is_running -eq 0 ]];then
	id=$(hyprctl clients -j | jq --arg name $player_name -r '.[] | select(.class | ascii_downcase | contains($ARGS.named.name)).workspace["id"]')
	#echo "id is " $id
	class=$(hyprctl clients -j | jq --arg name $player_name -r '.[] | select(.class | ascii_downcase | contains($ARGS.named.name)).class')
	hyprctl dispatch workspace $id #&& echo "Moved to ${id}"
	hyprctl dispatch focuswindow $class #&& echo "Focused ${class}"
else
	$player_name
fi

#exec $player_name

