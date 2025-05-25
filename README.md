# Dot-Vault
My own dotfile management tool, written in Lua!

Still need to install the apps myself to the system not just run script

# How to install dependencies
`chmod +x install.sh ; ./install.sh`

# How to make script global
Give correct permissions to script
`chmod +x dvc.lua`
Move to ~/.local/bin via sudo
`sudo mv dvc.lua /usr/local/bin/dvc`
or copy the file to ~/.local/bin
`sudo cp dvc.lua /usr/local/bin/dvc`

## Dependencies
`lua, git, luarocks`

## LuaRocks packages
`luafilesystem`
When installing luafilesystem(lfs) and using the script in `/usr/local/bin`
you'll want to install lfs as root so its global
