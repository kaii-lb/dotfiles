# MY DOT FILES WOOO
<sub>this is such a bad idea</sub>

## What it looks like (shit)

![Screenshot](/assets/images/screenshot.png)

## Installing

### Needed apps

- Window Manager: [Hyprland!](https://github.com/hyprwm/Hyprland) (obviously)
- Status Bar: [Hyprpanel](https://hyprpanel.com/)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- App Launcher: [rofi](https://github.com/davatorium/rofi)
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
- Some sort of polkit agent: [HyprPolkitAgent](https://wiki.hyprland.org/Hypr-Ecosystem/hyprpolkitagent/)
- Bluetooth tools: [Bluez](https://wiki.archlinux.org/title/bluetooth) and [Overskride](https://github.com/kaii-lb/overskride)
- Media Controls: [playerctl](https://github.com/altdesktop/playerctl)
- Lock Screen: [hyprlock](https://github.com/hyprwm/hyprlock)
- Wallpaper: [hyprpaper](https://github.com/hyprwm/hyprpaper)
- Screenshot freezer: [hyprpicker](https://github.com/hyprwm/hyprpicker) (freezes the screen for area screenshots, also doubles as colorpicker)
- Screen Shader Applier: [hyprshade](https://github.com/loqusion/hyprshade)
- Spotify Theming: [spicetify](https://spicetify.app/)
- Firefox Theming: [Catpuccin Mocha Lavender](https://addons.mozilla.org/en-US/firefox/addon/catppuccin-mocha-lavender-git/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- VSCode Theming: [Catpuccin Mocha Lavender](https://github.com/catppuccin/vscode)

### How to apply

- Copy files in `config` to `/home/$USER/.config/` or simply `~/.config/` (theyre the same place but yk fancier)
- Copy files in `local/bin` to `/home/$USER/.local/bin/` and set permissions to executable. (obv read the source code before executing anything)
- Run `hyprctl setcursor Bibata-Modern-Classic 24`
- Run `gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic` to set cursor theme
- Run `gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:appmenu'` to move window buttons to left (optional)
- Run `spicetify backup apply` to apply the spicetify themes and plugins
- Go to `/home/$USER/.config/hypr/scripts/` and set everything to executable.
- Go to `/home/$USER/.config/rofi/bin/` and set everything to executable.
- Go to `/home/$USER/.config/hyprpanel/scripts/` and set everything to executable.
- Open `/home/$USER/.config/hyprpanel/config.json` and change `menus.clock.weather.location`'s value to your location
- Open `/home/$USER/.config/hyprpanel/config.json` and change `menus.clock.weather.key`'s value to your WeatherApi key
- Open `/home/$USER/.config/hyprland/hyprpaper.conf` and set the wallpaper path
- Reboot
- Profit(?)

### Using the apps and tricks and shit
- Super + Enter is app launcher
- Super + L is power options
- Super + P gives a color picker (auto copies hex color to clipboard)
- Control + Shift + K kills selected window
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
- Super + B to open overskride (bluetooth manager)
- Super + Right-Click resizes window
- Super + Left-Click moves window

### Special Thanks
- [adi1090x](https://github.com/adi1090x) for the basis of the rofi menus!
- [loqusion](https://github.com/loqusion/hyprshade) for making shader usage a breeze
- My cat Darcie for supporting me thru these less-than-good times
