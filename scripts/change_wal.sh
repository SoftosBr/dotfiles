#!/usr/bin/env bash
wallpaper=$(grep "path" "$HOME/.config/hypr/hyprpaper.conf" | awk '{print $3}')
matugen image "$wallpaper"

scripts_folder="$HOME/scripts"
if [ ! -d "$scripts_folder" ]; then
  echo "The folder '$scripts_folder' doesn't exist"
  exit 1
fi

execute_script() {

  script_file=$1
  if [ -f "$scripts_folder/$script_file" ]; then
    source "$scripts_folder/$script_file" &>/dev/null &
  fi
}

execute_script "launch_dunst.sh"
execute_script "launch_waybar.sh"

killall hyprpaper
hyprpaper &

pywalfox update
hyprctl reload
echo "Wallpaper updated"
