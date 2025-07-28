#!/bin/sh

language=$(hyprctl devices | grep -A 3 "$DEVICE$" | grep "at-translated-set-2-keyboard" -A 3 | grep "active keymap:" | tail -n 1 | awk '{print tolower(substr($3,1,2))}')

echo $language >> /tmp/current_language
