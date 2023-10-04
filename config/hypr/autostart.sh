#!/usr/bin/bash

# plugins
# hyprctl plugin load $HOME/.config/hypr/plugins/csgo-vulkan-fix.so

# variables
config=$HOME/.config/hypr
scripts=$config/scripts

# might help with long time to launch app
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
gnome-keyring-daemon --start --components=secrets

# notification daemon
dunst &

# waybar
$scripts/launch_waybar &
brightnessctl set 50% &

# polkit agent (password prompt)
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# just incase, force these variables
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
/usr/lib/xdg-desktop-portal-gtk -v -r &

# sometimes bluetooth and/or wifi get blocked, this unblocks them
rfkill unblock all &

# set the cursor
hyprctl setcursor Bibata-Modern-Classic 24 &

# use only if obex doesn't work by default for you
/usr/lib/bluetooth/obexd -n &

# force gtk settings (last resort type shit)
# gsettings set org.gnome.desktop.a11y.interface high-contrast true
# gsettings set org.gnome.desktop.interface color-scheme prefer-dark
# gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic
# gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
# gsettings set org.gnome.desktop.wm.preferences theme adw-gtk3-dark
# 
# set the hyprland splash text on top of your wallpaper (needs chaning hyprpaper conf to work)
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

# launch hyprpaper (wallpaper daemon thingy wtv)
hyprpaper &









