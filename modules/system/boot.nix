{
  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;
      grub = {
        enable = true;
        device = "nodev";
        configurationLimit = 10;      
      };
    };
  };
}