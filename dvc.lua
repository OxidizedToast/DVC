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
  local home = os.getenv("HOME")
  local used_configs = io.open("used_configs.txt", "r")
  if not used_configs then
    error("used_contifs.txt not found")
  end
  local used_configs_contents = used_configs:read("*a")
  used_configs:close()
 local current_directory = lfs.currentdir()
  print("Installing...")
  get_dots()
  lfs.chdir(current_directory .. "/dotfiles")
  check_in_dots()
  os.execute("mv fonts " .. home .. "/.local/share/fonts")
  os.execute("mv helpful " .. home)
  os.execute("mv Wallpapers " .. home)
  os.execute("mv config/" .. used_configs_contents .. home .. " /.config/")
  os.execute("mv config/bashrc " .. home .."/.bashrc")
end

function check_in_dots()
  if not lfs.currentdir():match("dotfiles$") then
    print("Failed to enter dotfiles directory")
    os.exit(1)
  end
end

function push_dots()
  check_in_dots()
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
