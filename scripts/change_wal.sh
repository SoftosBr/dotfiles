#!/usr/bin/env bash


wallpaper=$(grep "file=" $HOME/.config/nitrogen/bg-saved.cfg | tail -n 1 | cut -d'=' -f2)
wal -q -i "$wallpaper"
wal-telegram --wal

feh --no-fehbg --bg-scale "$wallpaper"


scripts_folder="$HOME/scripts"
if [ ! -d "$scripts_folder"  ]; then
    echo "The folder '$scripts_folder' doesn't exist"
    exit 1
fi

execute_script(){
	
	script_file=$1
	if [ -f "$scripts_folder/$script_file" ]; then
		source "$scripts_folder/$script_file" &> /dev/null &
	fi
}

execute_script "launch_dunst.sh"
execute_script "change_kitty_colors.sh"
execute_script "launch_polybar.sh"

pywalfox update

