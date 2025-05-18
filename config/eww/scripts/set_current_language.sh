#!/bin/sh

language=$(hyprctl devices | grep -A 3 "$DEVICE$" | grep "active keymap:" | tail -n 1 | awk '{print tolower(substr($3,1,2))}')

echo $language >> /tmp/current_language
