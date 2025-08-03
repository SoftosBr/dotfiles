#!/bin/bash
WALLPAPER_DIR="$HOME/dotfiles/Pictures/Wallpapers"
KITTY_CONF_PATH="$HOME/.config/kitty/kitty.conf"
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

if ! grep -q "^background_image" "$KITTY_CONF_PATH"; then
  echo "" >>"$KITTY_CONF_PATH"
  echo "background_image ${SELECTED_WALLPAPER}" >>"$KITTY_CONF_PATH"
else
  sed -i "s|^background_image.*|background_image ${SELECTED_WALLPAPER}|" "${KITTY_CONF_PATH}"
fi

SCRIPTS_PATH="$HOME/scripts"
if [ ! -f "$SCRIPTS_PATH/change_wal.sh" ]; then
  echo "Error: change_wal script not found"
  exit 1
fi

source "$SCRIPTS_PATH/change_wal.sh"
