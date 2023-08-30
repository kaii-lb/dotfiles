#!/usr/bin/sh

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export WAYLAND_DISPLAY=wayland-1
export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$(id -u).$(pgrep -x sway).sock

swaylockd \
--screenshots \
--indicator \
--clock \
--timestr "%I:%M:%S" \
--inside-wrong-color ca7563  \
--ring-wrong-color 3f2d3c  \
--inside-clear-color f5b061 \
--ring-clear-color 3f2d3c \
--inside-ver-color f9f871 \
--ring-ver-color 423040 \
--text-color faf8ff \
--indicator-radius 160 \
--indicator-thickness 15 \
--effect-blur 4x4 \
--effect-vignette 0.2:0.2 \
--ring-color 0011111b \
--key-hl-color f9f871 \
--line-color 313244 \
--inside-color 3f2d3c00 \
--separator-color 00000000 \
--fade-in 0.2 && echo "Locked Succesfully"

echo -e "XDG_RUNTIME_DIR is: ${XDG_RUNTIME_DIR}\nWAYLAND_DISPLAY is: ${WAYLAND_DISPLAY}\nSWAYSOCK is: $SWAYSOCK"

unset XDG_RUNTIME_DIR

#hyprctl dispatch cyclenext

sudo intelpwm
