#!/bin/sh

pid=$(pgrep wl-screenrec)

# echo $pid

if [[ $pid == "" ]]; then
	echo "wl-screenrec not running"
	exit 1
fi	

kill -s 2 $pid
