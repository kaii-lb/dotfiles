# MY DOT FILES WOOO
<sub>this is such a bad idea</sub>

## What it looks like (shit)

![Screenshot](/assets/images/screenshot.png)
![Utilities](/assets/images/utilities.png)

## Installing

### Needed apps

- Window Manager: [Hyprland!](https://github.com/hyprwm/Hyprland) (obviously)
- Status Bar: [Waybar](https://github.com/Alexays/Waybar) (also obviously & use hyprland/workspaces if ur having issues with workspaces)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- App Launcher: [rofi](https://github.com/davatorium/rofi)
- Notification Daemon: [dunst](https://github.com/dunst-project/dunst)
- Terminal Text Editor: [micro](https://github.com/zyedidia/micro)
- File Manager: [Nautilus](https://github.com/GNOME/nautilus) 
- Audio: [Pipewire](https://gitlab.freedesktop.org/pipewire/pipewire/) and [Wireplumber](https://gitlab.freedesktop.org/pipewire/wireplumber/) (you should be able to use pulse audio but im not sure)
- Audio control: [pamixer](https://github.com/cdemoulins/pamixer) (yes it for pulseaudio but works with pipewire better than wpctl)
- Logout Manager/App/Thingy: [rofi](https://github.com/davatorium/rofi)
- Modifications for GTK/LibAdwaita: [gradience](https://github.com/GradienceTeam/Gradience) 
- Hyprland Shader Applier: [Hypershade!](https://github.com/loqusion/hyprshade)
- Fonts: [Font Awesome 6 Pro](https://fontawesome.com/) and Product Sans (can't give u a link for this one, but nothing will work without it)
- Cursor: [Bibata-Modern-Classic](https://github.com/ful1e5/Bibata_Cursor)
- App for setting said themes: [lxappearance](https://github.com/lxde/lxappearance)
- Screen Recorder : [wl-screenrec](https://github.com/russelltg/wl-screenrec) (you need slurp for area recordings) 
- Screen Shots: [grimblast](https://github.com/hyprwm/contrib)
- Alternate Screen Shots: [grim](https://sr.ht/~emersion/grim/) and [slurp](https://github.com/emersion/slurp)
- Some sort of polkit agent: [kde's](https://github.com/KDE/polkit-kde-agent-1) is best for hyprland as per docs
- Bluetooth tools: [Bluez](https://wiki.archlinux.org/title/bluetooth) and [bluetuith](https://github.com/darkhz/bluetuith)
- Media Controls: [playerctl](https://github.com/altdesktop/playerctl)
- Lock Screen: [swaylockd](https://github.com/jirutka/swaylockd) and [swaylock-effect](https://github.com/mortie/swaylock-effects)
- Wallpaper: [hyprpaper](https://github.com/hyprwm/hyprpaper)
- Screenshot freezer: [hyprpicker](https://github.com/hyprwm/hyprpicker) (freezes the screen for area screenshots, also doubles as colorpicker)
- Screen Shader Applier: [hyprshade](https://github.com/loqusion/hyprshade)
- Spotify Theming: [spicetify](https://spicetify.app/)
- Firefox Theming: [dark vibes :D](https://addons.mozilla.org/en-US/firefox/addon/dark-vibes/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- VSCode Theming: [dark vibes :D](https://github.com/kaii-lb/Dark-Vibes-VsCode)
- Bluetooth Battery: [bluetooth-headset-battery-level](https://github.com/TheWeirdDev/Bluetooth_Headset_Battery_Level)

### How to apply

- Copy files in `config` to `/home/$USER/.config/` or simply `~/.config/` (theyre the same place but yk fancier)
- Copy files in `local/bin` to `/home/$USER/.local/bin/` and set permissions to executable. (obv read the source code before executing anything)
- Copy files in `config/spicetify/Themes/` to `/home/$USER/.config/spicetify/Themes` and apply using `spictify-cli`
- Copy files in `firefox` to `/home/$USER/.mozilla/FIREFOX_PROFILE_THINGY/chrome/`
- Run `hyprctl setcursor Bibata-Modern-Classic 24`
- Run `gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic` to set cursor theme
- Run `gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:appmenu'` to move window buttons to left (optional)
- Go to `/home/$USER/.config/hypr/` and set the `autostart` file to executable.
- Go to `/home/$USER/.config/hypr/scripts/` and set everything to executable.  
- Go to `/home/$USER/.config/rofi/bin/` and set everything to executable.  
- Go to `/home/$USER/.config/waybar/scripts/` and set everything to executable.  
- Import `dark-ass-mf.json` from `presets/user` to gradience and apply for gtk3 and gtk4
- Import the `dark-vibes-yay.vsix` that you downloaded to vscode and set color scheme to `dark vibes :D`
- Open `/home/$USER/.config/waybar/scripts/weather.py` and replace `mycity+mycountry` with your city and country
- Open `/home/$USER/.config/hyprland/hyprpaper.conf` and set the wallpaper path
- Open firefox, go to `about:config` and search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set it to `true`
- Reboot
- Profit(?)

### Using the apps and tricks and shit
- Left click on some stuff in waybar to get cool things
- Right click on some stuff in waybar to get cool things
- Scroll some stuff in waybar to get cool things
- Left click bluetooth icon in wifi menu to get to bluetooth menu
- Left click on weather icon to get forecast
- Super + Enter is app launcher 
- Super + L is power options
- Super + Control + Shift + R reloads waybar incase it freezes
- Super + Shift + P gives a color picker (auto copies hex color to clipboard)
- Control + Shift + L gives some love emoticons (because some of us have gfs)
- Control + Shift + K kills active window
- Super + Arrows moves windows
- Control + Alt + Arrows resizes windows
- Control + Super + Arrows changes focused window
- Super + Number-Row switches to workspace of number X
- Alt + Number-Row moves window to workspace of number X
- PrintScreen is screenshots
- Shift + PrintScreen is instant area screenshot
- Super + Shift + PrintScreen is instant window screenshot
- Super + PrintScreen is screenrecord
- Super + F is fullscreen 
- Super + Q to exit current app
- Super + S to toggle floating window
- Super + E to open nautilus (file manager)
- Super + B to open bluetooth menu
- Super + O to toggle waybar
- Super + Right-Click resizes window
- Super + Left-Click moves window 

### Special Thanks
- [adi1090x](https://github.com/adi1090x) for the basis of the rofi menus!
- [loqusion](https://github.com/loqusion/hyprshade) for making shader usage a breeze
- My cat Darcie for supporting me thru these less-than-good times
