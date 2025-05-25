#!/bin/bash
sudo pacman -Sy
sudo pacman -S lua git luarocks
luarocks config local_by_default true
luarocks install luafilesystem
sudo pacman -S alacritty gtk2 gtk3 gtk4 hyprpaper hyprlock mako nvim wofi waybar zoxide eza bat
