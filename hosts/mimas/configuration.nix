{ ... }: {
  zen = {
    host.name = "mimas";

    session = {
      default = "niri";
      plasma.enable = true;
      niri.enable = true;

      monitors = [{
        name        = "eDP-1";
        resolution  = "1920x1080";
        offset      = "0x0";
        refreshRate = 60;
        workspaces  = [ 1 2 3 4 5 ];
      }];
    };

    services = {
      dunst.enable = true;
      tofi.enable = true;
      swww.enable = true;
      dms.enable = true;
    };

    apps = {
      zen-browser.enable = true;
      obsidian.enable = true;

      gaming.enable = true;
      discord.enable = true;
      signal.enable = true;

      anki.enable = true;
      komikku.enable = true;

      feishin.enable = true;
      media = {
        image.gwenview.enable = true;
        video.mpv.enable = true;
        audio.elisa.enable = true;
      };
    };
  };
  services.upower.enable = true;

  users.users.skye = {
    isNormalUser = true;
    description = "skye";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "skye";

  system.stateVersion = "23.11";
}
