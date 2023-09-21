#!/usr/bin/bash

#plugins
#hyprctl plugin load $HOME/.config/hypr/plugins/csgo-vulkan-fix.so

#might help with long time to launch app
dbus-update-activation-environment --all
gnome-keyring-daemon --start --components=secrets

xsettingsd --config $HOME/.config/xsettingsd/xsettingsd.conf &

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
QT_STYLE_OVERRIDE=kvantum /usr/lib64/polkit-kde-authentication-agent-1 &
QT_STYLE_OVERRIDE=kvantum /usr/lib64/polkit-kde-authentication-agent-1 &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

brightnessctl set 50% &

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

rfkill unblock all &

#hyprctl setcursor Bibata-Modern-Classic 24
hyprctl setcursor Bibata-Modern-Classic 24 &

# use only if obex doesn't work by default for you
/usr/lib/bluetooth/obexd -n &

gsettings set org.gnome.desktop.a11y.interface high-contrast true
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
gsettings set org.gnome.desktop.wm.preferences theme adw-gtk3-dark

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
hyprpaper &
#hyprctl hyprpaper unload all






