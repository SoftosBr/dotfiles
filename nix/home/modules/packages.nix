{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    brightnessctl
    btop
    fd
    fzf
    grim
    lazygit
    neovim
    pavucontrol
    playerctl
    ripgrep
    slurp
    wl-clipboard
    yazi
  ];

  programs.git.enable = true;
}
