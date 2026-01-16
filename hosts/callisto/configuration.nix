{ ... }: {
  zen = {
    host.name = "callisto";
    system.steamdeck = {
      enable = true;
      username = "skye";
    };

    apps = {
      zen-browser.enable = true;
      feishin.enable = true;
      bottles.enable = true;
      gaming = {
        lutris.enable = true;
        minecraft.prism.enable = true;
        r2modman.enable = true;
      };
      media = {
        image.gwenview.enable = true;
        video.mpv.enable = true;
        video.vlc.enable = true;
        audio.elisa.enable = true;
      };
    };
  };

  users.users.skye = {
    isNormalUser = true;
    description = "skye";
    extraGroups = [ "networkmanager" "wheel" "video" "seat" "audio" "libvirtd" ];
  };

  system.stateVersion = "26.05";
}
