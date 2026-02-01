{ pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    btop
    fd
    bat
  ];
}