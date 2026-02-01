{ pkgs, ... }:

{
  fonts = {
    fontconfig = {
      subpixel = {
        rgba = "rgb";
        lcdfilter = "light";
      };

      defaultFonts = {
        serif = [
          "FiraCode Nerd Font"
          "DejaVu Serif"
        ];

        sansSerif = [
          "FiraCode Nerd Font"
          "DejaVu Sans"
        ];

        monospace = [
          "FiraCode Nerd Font"
          "DejaVu Sans Mono"
        ];

        emoji = [
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
      };
    };

    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
    ];
  };
}