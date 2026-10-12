#!/usr/bin/env bash

path=$(pwd)

handle_cd_error() {
	echo "Error: Failed to change directory. The directory $1 may not exist "
	exit 1
}

if (( EUID == 0 )); then
    echo "Execute como usuário comum com acesso ao sudo, sem sudo ./install.sh." >&2
    exit 1
fi
if ! command -v pacman >/dev/null; then
    echo "Este instalador requer Arch Linux no WSL." >&2
    exit 1
fi
if ! grep -qi microsoft /proc/sys/kernel/osrelease; then
    echo "Este instalador deve ser executado dentro do WSL." >&2
    exit 1
fi
if ! command -v sudo >/dev/null; then
    echo "Instale sudo e conceda acesso ao seu usuário antes de continuar." >&2
    exit 1
fi

packages=(
    base-devel git curl ca-certificates zsh stow unzip zip man-db
    fzf ripgrep bat htop btop neovim lazygit
    python python-pip
    fontconfig ttf-nerd-fonts-symbols noto-fonts-cjk noto-fonts-emoji
    noto-fonts ttf-hack-nerd ttf-fira-code ttf-firacode-nerd neofetch
)


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

echo "Atualizando o sistema e instalando ferramentas e fontes..."
yay -Syu --needed --noconfirm "${packages[@]}"

#Bkp
mv "$HOME/.zshrc" "$HOME/.zshrc_bak" 2>dev/null || true

stow -t="$HOME" -R zsh

echo "Installing and configuring oh-my-zsh"
KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git "/${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

if ! echo "$SHELL" | grep -q zsh; then
	chsh -s /usr/bin/zsh
fi

echo "Concluído. Abra uma nova sessão do WSL ou execute: exec zsh"
