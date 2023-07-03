#!/usr/bin/bash

#plugins
#hyprctl plugin load /home/$USER/.config/hypr/plugins/csgo-vulkan-fix.so

# variables
config=$HOME/.config/hypr
scripts=$config/scripts

# notification daemon
dunst &

# waybar
$scripts/launch_waybar &
#$scripts/tools/dynamic &

# wallpaper
#$scripts/wall /home/$USER/Pictures/NewWallpapers/r32.png &
hyprpaper 
#hyprctl hyprpaper unload all
#/home/kai/.local/bin/wallpaper.sh

# effects
#$scripts/rgb &

# other
/usr/lib64/polkit-kde-authentication-agent-1 &
/usr/lib64/polkit-kde-authentication-agent-1 &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

brightnessctl set 15%

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

rfkill unblock all

#hyprctl setcursor Bibata-Modern-Classic 24
#hyprctl setcursor Bibata-Modern-Classic 24

sudo intelpwm
