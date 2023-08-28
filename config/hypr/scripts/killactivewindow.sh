#!/bin/sh

hyprvars=$(hyprctl activewindow -j | jq '.pid')
#echo $pid

kill -9 $pid
