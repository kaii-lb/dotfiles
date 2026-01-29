#!/bin/sh

# pulse keyboard LEDs, fixes led lights on after sleep (even tho caps/num/fn lock isn't on)
brightnessctl -d platform::fnlock set 1
brightnessctl -d input3::capslock set 1
brightnessctl -d input3::numlock set 1

sleep 1
brightnessctl -d platform::fnlock set 0
brightnessctl -d input3::capslock set 0
brightnessctl -d input3::numlock set 0
