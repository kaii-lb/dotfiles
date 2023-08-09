#!/bin/sh

player=$(playerctl --player=io,com,spotify,%any,firefox metadata --format '{{playerName}}')
class=""

if [[ $player =~ "io" ]]; then
	hyprvars=$(hyprctl clients -j | cut -d' ' -f2- | head -n -1 | tail -n +4)
	class=$(echo -e "[{\n$hyprvars\n}]" | jq -r '.[] | select(.class | startswith("io")).class')
	player_name=$(echo $class | grep -oE '[^. ]+$' | awk '{print tolower($0)}')
elif [[ $player =~ "com" ]]; then
	hyprvars=$(hyprctl clients -j | cut -d' ' -f2- | head -n -1 | tail -n +4)
	class=$(echo -e "[{\n$hyprvars\n}]" | jq -r '.[] | select(.class | startswith("com")).class')
	player_name=$(echo $class | grep -oE '[^. ]+$' | awk '{print tolower($0)}')
elif [[ $player =~ "mpd" ]]; then
	kitty ncmpcpp && exit 0

else
	hyprvars=$(hyprctl clients -j | cut -d' ' -f2- | head -n -1 | tail -n +4)
	class=$(echo -e "[{\n$hyprvars\n}]" | jq --arg name $player -r '.[] | select(.class | ascii_downcase | startswith("$ARGS.named.name")).class')
	player_name=$player
fi

is_running=$(pgrep $player_name > /dev/null && echo 0)

echo "Player is: "$player

if [[ $is_running -eq 0 ]];then
	hyprvars=$(hyprctl clients -j | cut -d' ' -f2- | head -n -1 | tail -n +4)
	id=$(echo -e "[{\n$hyprvars\n}]" | jq --arg name $player -r '.[] | select(.class | ascii_downcase | contains($ARGS.named.name)).workspace["id"]')
	echo "id is " $id
	class=$(echo -e "[{\n$hyprvars\n}]" | jq --arg name $player -r '.[] | select(.class | ascii_downcase | contains($ARGS.named.name)).class')
	hyprctl dispatch workspace $id && echo "Moved to ${id}"
	hyprctl dispatch focuswindow $class && echo "Focused ${class}"
else
	$player_name
fi

#exec $player_name

