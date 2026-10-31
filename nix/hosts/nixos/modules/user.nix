{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.henrique = {
    isNormalUser = true;
    description = "Henrique";
    extraGroups = [ "audio" "input" "networkmanager" "video" "wheel" ];
    shell = pkgs.zsh;
  };
}
