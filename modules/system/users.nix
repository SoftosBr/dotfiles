{ pkgs, ... }:

{
  users.users.nix-user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs.fish.enable = true;
}