#!/usr/bin/env lua
local lfs = require("lfs")

function help_screen()
  print([[ 
  Usage: dv [options]
    Options:
    -help    || -h  - Prints this screen
    -install || -i  - Installs dotfiles into system
    -get     || -g  - Gets dotfiles
    -push    || -p  - Pushes dotfiles
    -version || -v  - Version of tool
  ]])
end
function version()
  local project_verison = "v1.2.0-beta"
  print("Current version: " .. project_verison)
end

function installation()
  local used_configs = io.open("used_configs.txt", "r")
  if not used_configs then
    error("used_contifs.txt not found")
  end
  local used_configs_contents = used_configs:read("*a")
  used_configs:close()

  print("Installing...")
  get_dots()
  lfs.chdir("dotfiles")
  if lfs.currentdir() ~= "dotfiles" then
    print("Failed to enter dotfiles directory")
    os.exit(1)
  end
  os.execute("mv fonts ~/.local/share/fonts")
  os.execute("mv helpful ~")
  os.execute("mv Wallpapers ~")
  os.execute("mv " .. used_configs_contents .. " ~/.config/")
  os.execute("mv config/bashrc ~/.bashrc")
end

function check_directory()
  local current_dir = lfs.currentdir()

  if current_dir == "dotfiles" then
  else
    print("Not in dotfiles directory \n exiting...")
    os.exit(1)
  end
end

function push_dots()
  check_directory()
  print("What is the commit message?")
  local message = io.read()
  os.execute("git add .")
  os.execute("git commit -m " .. message)
  os.execute("git push origin main")
end

function get_dots()
local git_link = "https://github.com/oxidizedtoast/dotfiles"
  os.execute("git clone --quiet " .. git_link)
  print("Dotfiles gathered")
end

local command = arg[1] or ""
if command == "-help" or command == "-h" then
  help_screen()
elseif command == "-install" or command == "-i" then
  installation()
elseif command == "-push" or command == "-p" then
  push_dots()
elseif command == "-get" or command == "-g" then
  get_dots()
elseif command == "-version" or command == "-v" then
  version()
elseif command == "" then
  print("No command entered, see '-h' for options")
  os.exit(1)
else
  print("Unknown option: " .. command)
  help_screen()
end
