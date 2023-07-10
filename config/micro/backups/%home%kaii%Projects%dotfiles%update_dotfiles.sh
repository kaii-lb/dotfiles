#!/bin/sh

cp ~/.config/hypr/ -R ~/Projects/dotfiles/config/
cp ~/.config/waybar -R ~/Projects/dotfiles/config/
cp ~/.config/kitty -R ~/Projects/dotfiles/config/
cp ~/.config/dunst -R ~/Projects/dotfiles/config/
cp ~/.config/micro -R ~/Projects/dotfiles/config/
cp ~/.config/rofi -R ~/Projects/dotfiles/config/
cp ~/.config/presets -R ~/Projects/dotfiles/config/
cp ~/.local/bin/*.sh -R ~/Projects/dotfiles/local/

sed -i "s/Salima+Lebanon/mycity+mycountry/" ~/Projects/dotfiles/config/waybar/scripts/weather.py

read -p "Did you update README? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

#git add . 

#read -p "Commit Name: " commit_name

#git commit -m "${commit_name}"

#git push origin master
