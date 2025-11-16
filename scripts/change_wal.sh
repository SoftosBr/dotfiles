#!/usr/bin/env bash
wallpaper=$(grep "^preload" "$HOME/.config/hypr/hyprpaper.conf" | awk '{print $3}')
wal -q -i "$wallpaper"
wal-telegram --wal

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

execute_script "change_kitty_colors.sh"

killall hyprpaper
hyprpaper &

pywalfox update
echo "Wallpaper updated"
