#!/bin/bash

# stolen from https://github.com/arfan-on-clouds/hyprclouds/blob/dc56aa5563da58ba1fd757c607a8630493686647/config/eww/scripts/positions.sh

playerctl metadata -F -f '{{position}} {{mpris:length}}' | while read -r line; do
    position=$(playerctl metadata -f "{{position / 1000000}}")
    position=$(echo "($position + 0.5) / 1" | bc)
    positionStr=$(playerctl metadata -f "{{duration(position)}}")
    player=$(playerctl metadata -f "{{playerName}}")
    state=$(playerctl metadata -f "{{status}}")

    JSON_STRING=$( jq -n \
                --arg position "$position" \
                --arg state "$state" \
                --arg positionStr "$positionStr" \
                --arg player "$player" \
                '{$player: {position: $position, positionStr: $positionStr, state: $state}}' )
    echo $JSON_STRING

done
