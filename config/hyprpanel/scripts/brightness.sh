#!/bin/sh

echo $(brightnessctl i | head -n2 | tail -n1 | cut -f4 -d' ' | sed -e "s/(//" -e "s/%)//")
