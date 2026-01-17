{ ... }: {
  zen = {
    host.name = "kari";
    system.steamdeck = {
      enable = true;
      username = "steve";
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
    };
  };

  users.users.steve = {
    isNormalUser = true;
    description = "steve";
    extraGroups = [ "networkmanager" "wheel" "video" "seat" "audio" "libvirtd" ];
  };

  system.stateVersion = "26.05";
}
