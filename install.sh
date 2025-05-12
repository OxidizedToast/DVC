#!/bin/bash
sudo pacman -Syu
sudo pacman -S lua git luarocks
luarocks config local_by_default true
luarocks install luafilesystem
