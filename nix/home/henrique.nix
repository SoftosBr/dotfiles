{
  imports = [
    ./modules/dms.nix
    ./modules/files.nix
    ./modules/kitty.nix
    ./modules/packages.nix
    ./modules/shell.nix
  ];

  home = {
    username = "henrique";
    homeDirectory = "/home/henrique";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
