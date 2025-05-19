#!/bin/sh

state=$(upower -d | grep state | tail -n1 | sed 's/state://g' | tr -d ' ')

if [[ $state == "charging" ]]; then
	echo true
else
	echo false
fi
