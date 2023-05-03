#!/usr/bin/sh

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export WAYLAND_DISPLAY=wayland-1
export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$(id -u).$(pgrep -x sway).sock

swaylockd \
--screenshots \
--indicator \
--clock \
--timestr "%I:%M:%S" \
--inside-wrong-color f38ba8  \
--ring-wrong-color 11111b  \
--inside-clear-color a6e3a1 \
--ring-clear-color 11111b \
--inside-ver-color b4befe \
--ring-ver-color 11111b \
--text-color  f5c2e7 \
--indicator-radius 160 \
--indicator-thickness 15 \
--effect-blur 10x7 \
--effect-vignette 0.2:0.2 \
--ring-color 0011111b \
--key-hl-color b4befe \
--line-color 313244 \
--inside-color 0011111b \
--separator-color 00000000 \
--fade-in 0.1 && echo "Locked Succesfully"

echo -e "XDG_RUNTIME_DIR is: ${XDG_RUNTIME_DIR}\nWAYLAND_DISPLAY is: ${WAYLAND_DISPLAY}\nSWAYSOCK is: $SWAYSOCK"

unset XDG_RUNTIME_DIR

#hyprctl dispatch cyclenext
