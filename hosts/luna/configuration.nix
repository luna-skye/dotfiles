{ ... }: {
  imports = [ ];

  bead = {
    host.name = "luna";
    hyprland = {
      enable = true;
      monitors = [
        {
          name = "DP-1";
          resolution = "2440x1440";
          offset = "0x0";
          refreshRate = 165;
          workspaces = [1 2 3 4 5];
        }
        {
          name = "HDMI-A-1";
          resolution = "1920x1080";
          offset = "2560x360";
          refreshRate = 60;
          workspaces = [6 7 8 9];
        }
      ];
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "skye";
}
