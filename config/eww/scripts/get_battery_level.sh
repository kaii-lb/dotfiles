#!/bin/sh

battery_level=$(upower -d | grep percentage | tail -n1 | tr -d '['', 'percentage:', '%']')

echo $battery_level
