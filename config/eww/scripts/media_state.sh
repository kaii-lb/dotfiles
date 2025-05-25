#!/bin/sh

playerctl metadata -F | while read -r line; do
    metadata=$(playerctl metadata --format '{"player":"{{playerName}}","title":"{{title}}","artist":"{{artist}}","position":"{{position / 1000000}}", "position_str":"{{duration(position)}}", "length": "{{mpris:length}}","length_str":"{{duration(mpris:length)}}","art":"{{mpris:artUrl}}","status":"{{status}}"}')
    echo $metadata
done
