#!/bin/sh

if pidof gpu-screen-recorder &>/dev/null; then
	echo true
else
	echo false
fi
