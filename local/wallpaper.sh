is_running=$(pgrep hyprpaper > /dev/null && echo 0)

if [[ $is_running != 0 ]];then
	hyprpaper &
fi


file=$(shuf -n1 -e /home/kai/Pictures/NewWallpapers/*)
#touch ~/.local/bin/current_wallpaper.txt

last_wallpaper=$file

file=$(shuf -n1 -e /home/kai/Pictures/NewWallpapers/*)
#last_wallpaper=$(cat ~/.local/bin/current_wallpaper.txt)

if [[ "${last_wallpaper}" = $file ]]; then
	file=$(shuf -n1 -e /home/kai/Pictures/NewWallpapers/*)
fi

#gsettings set org.gnome.desktop.background picture-uri-dark ${file} 
#sh ~/.config/hypr/scripts/wall $file
hyprctl hyprpaper preload $file
hyprctl hyprpaper wallpaper eDP-1,$file
hyprctl hyprpaper unload last_wallpaper 

#sed -i '1d' ~/.local/bin/current_wallpaper.txt
#echo $file > ~/.local/bin/current_wallpaper.txt

notify-send -t 1000 "Wallpaper Has Been Changed" "The wallpaper has been switchout out randomly."

