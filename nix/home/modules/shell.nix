{ lib, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      la = "ls -la";
      vim = "nvim";
    };

    initContent = lib.mkBefore ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "";
    };
  };
}
