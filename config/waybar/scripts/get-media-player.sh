#!/bin/sh

player=$(playerctl --player=io,com,spotify,firefox,%any metadata --format '{{playerName}}')

if [[ $player -eq "io" ]]; then
	player_name=amberol
elif [[ $player -eq "com" ]]; then
	player_name=g4music
else
	player_name=$player
fi

exec $player_name

