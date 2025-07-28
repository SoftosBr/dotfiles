#!/usr/bin/env bash

path=$(pwd)

clear
echo " ░▒▓███████▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓███████▓▒░ "
echo "░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        "
echo "░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        "
echo " ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░    ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░  "
echo "       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░ "
echo "       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░ "
echo "░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓██████▓▒░░▒▓███████▓▒░  "
echo "                          https://github.com/SoftosBr                          "
echo ""
echo ""
echo ""
echo "Detecting Operating System..."
sleep 1 && clear

if ! command -v pacman &>/dev/null; then
  echo "You're not in a base arch system!"
  exit 1
fi

handle_cd_error() {
  echo "Error: Failed to change directory. The directory $1 may not exist "
  exit 1
}

packages_sound_system="alsa-lib alsa-utils pavucontrol mpv pulseaudio pipewire pipewire-pulse"
packages_i3="dunst picom polybar rofi"
packages_amd_driver="xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon"
packages_arch="fzf kitty neovim redshift stow htop btop dbus-python flameshot bat neofetch lxappearance npm python-pip python-pywal python-pywalfox wal-telegram-git telegram-desktop unzip xdg-user-dirs nitrogen yazi dolphin flameshot feh vlc ttf-nerd-fonts-symbols noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-hack-nerd ttf-firacode ttf-firacode-nerd lazygit obsidian discord clipcat zsh lightdm"

if grep -q "hypervisor" /proc/cpuinfo; then
  packages_i3=$(echo "$packages_i3" | sed 's/picom//g')
fi

if ! command -v yay &>/dev/null; then
  echo "Installing Yay..."
  yay_dir="/tmp/yay"
  rm -rf "$yay_dir" &>/dev/null
  git clone https://aur.archlinux.org/yay.git "$yay_dir"
  cd "$yay_dir" || handle_cd_error "$yay_dir"
  makepkg -sric --noconfirm
  cd "$path" || handle_cd_error "$path"
  rm -rf /tmp/yay
  echo "Yay installation finished successfully"
  sleep 1 && clear
fi


echo "Installing i3 Programs..."
yay -Syu ${packages_i3} --needed --noconfirm
sleep 1 && clear


echo "Installing sound system Programs..."
yay -Syu ${packages_sound_system} --needed --noconfirm
sleep 1 && clear


echo "Installing amd_driver Programs..."
yay -Syu ${packages_amd_driver} --needed --noconfirm
sleep 1 && clear


echo "Installing arch Programs..."
yay -Syu ${packages_arch} --needed --noconfirm
sleep 1 && clear

echo "Organizing dotfiles and configurations..."
xdg-user-dirs-update

mkdir "$HOME/scripts"
stow -t "$HOME/scripts" scripts

mv "$HOME/.config/i3/config" "$HOME/.config/i3/config.bak"
stow -t "$HOME/.config" .config --override='.*'

mv "$HOME/.zshrc" "$HOME/.zshrc_bak"
ln -s .zshrc "$HOME/.zshrc"

sudo usermod -aG video,input "$USER"

echo "Changing default shell to Zsh..."
if ! echo "$SHELL" | grep -q zsh; then
  chsh -s /usr/bin/zsh
fi
sleep 1 && clear

echo "All done"
read -r -p "For the changes to take effect properly, a system restart is required. Do you want to restart now? (y/n)" ans

case $ans in
"y" | "Y")
  reboot
  ;;
"n" | "N")
  exit 0
  ;;
*)
  echo "Invalid answer..."
  exit 0
  ;;
esac
