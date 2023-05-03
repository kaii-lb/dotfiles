# MY DOT FILES WOOO
<sub>this is such a bad idea</sub>

## What it looks like (shit)

![Screenshot](/assets/images/screenshot.png)
![Utilities](/assets/images/utilities.png)

## Installing

### Needed apps

- Window Manager: [Hyprland!](https://github.com/hyprwm/Hyprland) (obviously)
- Status Bar: [Waybar](https://github.com/Alexays/Waybar) (also obviously & use waybar-hyprland if ur having issues with workspaces)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- App Launcher: [rofi](https://github.com/davatorium/rofi)
- Notification Daemon: [dunst](https://github.com/dunst-project/dunst)
- Terminal Text Editor: [micro](https://github.com/zyedidia/micro)
- File Manager: [Nautilus](https://github.com/GNOME/nautilus) 
- Audio: [Pipewire](https://gitlab.freedesktop.org/pipewire/pipewire/) and [Wireplumber](https://gitlab.freedesktop.org/pipewire/wireplumber/) (you should be able to use pulse audio but im not sure)
- Logout Manager/App/Thingy: [rofi](https://github.com/davatorium/rofi)
- GTK theme: [Catppuccin-Mocha-Standard-Lavender](https://github.com/catppuccin/gtk)
- Fonts: [Font Awesome 6 Pro](https://fontawesome.com/) and Product Sans (can't give u a link for this one)
- Cursor: [Bibata-Modern-Classic](https://github.com/ful1e5/Bibata_Cursor)
- App for setting said themes: [lxappearance](https://github.com/lxde/lxappearance)
- Screen Recorder (no audio): [wf-recorder](https://github.com/ammen99/wf-recorder) (you need slurp for area recordings) 
- Screen ShotsL [grim](https://sr.ht/~emersion/grim/) and [slurp](https://github.com/emersion/slurp)
- Some sort of polkit agent ([kde's](https://github.com/KDE/polkit-kde-agent-1) is best for hyprland as per docs)
- Bluetooth tools: [Bluez](https://wiki.archlinux.org/title/bluetooth)
- Media Controls: [playerctl](https://github.com/altdesktop/playerctl)
- Lock Screen: [swaylockd](https://github.com/jirutka/swaylockd) and [swaylock-effect](https://github.com/mortie/swaylock-effects)

### Copying Files

- Copy files in `config` to `/home/$USER/.config/` or simply `~/.config/` (theyre the same place but yk fancier)
- Copy files in `local/bin` to `/home/$USER/.local/bin/` and set permissions to executable. (obv read the source code before executing anything)
- Copy files in `themes` to `/home/$USER/.local/share/themes/` and apply using `lxppearance` and `gnome-tweaks`
- Copy files in `icons` to `/home/$USER/.local/share/icons/` and apply using `lxppearance` and `gnome-tweaks`
- Run `hyprctl setcursor Bibata-Modern-Classic 24`
- Go to `/home/$USER/.config/hypr/` and set the `autostart` file to executable.
- Go to `/home/$USER/.config/hypr/scripts/` and set everything to executable.  
- Go to `/home/$USER/.config/rofi/bin/` and set everything to executable.  
- Go to `/home/$USER/.config/waybar/scripts/` and set everything to executable.  
- Reboot
- Profit
