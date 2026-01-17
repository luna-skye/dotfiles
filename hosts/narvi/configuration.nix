{ ... }: {
  zen = {
    host.name = "narvi";
    benchmarks.enable = true;
    session = {
      default = "plasma";
      plasma.enable = true;
    };
    printing.enable = true;
    apps = {
      zen-browser.enable = true;
      obsidian.enable = true;
      rgb.enable = true;
      gaming = {
        enable = true;
        mangohud.settings.fps_limit = 60;
        minecraft.prism.enable = true;
        r2modman.enable = true;
      };
      media = {
        image.gwenview.enable = true;
        video.vlc.enable = true;
        audio.elisa.enable = true;
      };
      feishin.enable = true;
      bottles.enable = true;
      discord.enable = true;
      signal.enable = true;
      mumble.enable = true;
      anki.enable = true;
      komikku.enable = true;
      office.enable = true;
    };
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.steve = {
    isNormalUser = true;
    description = "steve";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "steve";

  system.stateVersion = "23.11";
}
