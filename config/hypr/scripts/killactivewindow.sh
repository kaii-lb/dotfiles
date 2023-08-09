#!/bin/sh

hyprvars=$(hyprctl activewindow -j | cut -d' ' -f2- | head -n -1 | tail -n +4)
pid=$(echo -e "{\n$hyprvars\n}"| jq '.pid')

#echo $pid

kill -9 $pid
