{ inputs, ... }:

{
  imports = [ inputs.dms.homeModules.dank-material-shell ];

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = false;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = false;

    settings = {
      theme = "dark";
      dynamicTheming = true;
    };
  };
}
