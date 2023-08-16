#!/usr/bin/bash

#plugins
#hyprctl plugin load $HOME/.config/hypr/plugins/csgo-vulkan-fix.so

# variables
config=$HOME/.config/hypr
scripts=$config/scripts

# notification daemon
dunst &

# waybar
$scripts/launch_waybar &
#$scripts/tools/dynamic &

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

# wallpaper
# FONT="Product Sans Bold"
# SIZE=20
# STRING=$(hyprctl splash)
# spacing=$(inkscape --without-gui --query-id=id1 -W <(echo '<svg><text id="id1" style="font-size:'$SIZE'px;font-family:'$FONT';">'$STRING'</text></svg>') 2>/dev/null)
# spacing=${spacing%.*}
# spacing=$(($spacing/2 - 30))
# 
# wallpaper=/home/$USER/Pictures/NewWallpapers/languid-afternoon.jpg
# 
# convert $wallpaper -gravity East -font ~/.local/share/fonts/Product\ Sans\ Bold.ttf -fill white -pointsize 20 -annotate +$spacing+450 "$STRING" ~/Pictures/hyprpaper-image.png
hyprpaper 
#hyprctl hyprpaper unload all






