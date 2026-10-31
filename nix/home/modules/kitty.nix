{
  programs.kitty = {
    enable = true;

    font = {
      name = "Fira Code Nerd Font";
      size = 12;
    };

    settings = {
      background_opacity = "0.8";
      remote_relay = "yes";
    };

    # Gerados pelo DMS quando o tema ou wallpaper muda.
    extraConfig = ''
      include dank-tabs.conf
      include dank-theme.conf
    '';
  };
}
