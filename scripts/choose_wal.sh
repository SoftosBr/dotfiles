#!/bin/bash
WALLPAPER_DIR="$HOME/dotfiles/Pictures/Wallpapers"
WAL_CONF_PATH="$HOME/.config/hypr/hyprpaper.conf"
if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Error: Wallpaper dir not found"
  echo "Please configure the correct directory for the WALLPAPER_DIR variable"
  exit 1
fi

FZF_PREVIEW_COLUMNS_CUSTOM=$(($(tput cols) / 2))
FZF_PREVIEW_LINES_CUSTOM=$(tput lines)
export ICAT_PLACE=${FZF_PREVIEW_COLUMNS_CUSTOM:-64}x${FZF_PREVIEW_LINES_CUSTOM}@${FZF_PREVIEW_COLUMNS_CUSTOM:-64}x1
while true; do
  SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | fzf --preview "kitten icat --clear --transfer-mode=memory --stdin=no --place=${ICAT_PLACE} {} > /dev/tty")
  if [ -f "$SELECTED_WALLPAPER" ]; then
    break
  fi
done

if [ -z "$SELECTED_WALLPAPER" ]; then
  echo "No wallpaper selected. Operation cancelled."
  exit 1
fi

if [ ! -f "$WAL_CONF_PATH" ]; then
  touch "$WAL_CONF_PATH"
fi

# Clean hpyrpaper conf and change wallpaper
echo " " > "$WAL_CONF_PATH"
echo "preload = $SELECTED_WALLPAPER" >> "$WAL_CONF_PATH"
echo "wallpaper = , $SELECTED_WALLPAPER" >> "$WAL_CONF_PATH"
echo "splash = false" >> "$WAL_CONF_PATH"


SCRIPTS_PATH="$HOME/scripts"
if [ ! -f "$SCRIPTS_PATH/change_wal.sh" ]; then
  echo "Error: change_wal script not found"
  exit 1
fi

source "$SCRIPTS_PATH/change_wal.sh"
