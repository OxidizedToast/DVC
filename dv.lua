#!/usr/bin/env lua
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
local version = "v1.0.0-beta"

function version()
 print("Current version: " ..verison)
end

function installation()
  print("Installing...")
end

function check_directory()
  local handle = io.popen("basename " .. os.getenv("PWD"))
  local current_dir = handle:read("*l")
  handle:close()

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
