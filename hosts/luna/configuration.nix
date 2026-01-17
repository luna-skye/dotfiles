{ ... }: {
  zen = {
    host.name = "luna";
    # ups.enable = true;
    system = {
      fan2go = {
        enable = true;
        settings = import ./fans.nix;
      };
    };

    benchmarks.enable = true;

    session = {
      default = "niri";
      plasma.enable = true;
      hyprland.enable = false;
      niri.enable = true;

      monitors = [
        {
          name        = "DP-1";
          resolution  = "2560x1440";
          offset      = "0x0";
          refreshRate = 165;
          workspaces  = [ 1 2 3 4 5 ];
        }
        {
          name        = "HDMI-A-1";
          resolution  = "1920x1080";
          offset      = "2560x360";
          refreshRate = 60;
          workspaces  = [ 6 7 8 9 ];
        }
      ];
    };

    services = {
      swww.enable = true;
      tofi.enable = true;
      dunst.enable = true;
      dms.enable = true;
    };

    cli = {
      imagemagick.enable = true;
    };
    apps = {
      zen-browser.enable = true;
      chromium.enable = true;
      rgb.enable = true;
      media = {
        image.oculante.enable = true;
        video.vlc.enable = true;
        video.mpv.enable = true;
        audio.elisa.enable = true;
      };
      bottles.enable = true;

      obsidian.enable = true;
      blender.enable = true;
      blockbench.enable = true;
      aseprite.enable = true;
      inkscape.enable = true;
      krita.enable = true;
      davinci-resolve.enable = true;
      godot.enable = true;
      idea.enable = true;
      daw.enable = true;
      obs.enable = true;

      discord.enable = true;
      signal.enable = true;
      mumble.enable = true;

      anki.enable = true;
      komikku.enable = true;
      feishin.enable = true;
      gaming = {
        enable = true;
        lutris.enable = true;
        minecraft.atl.enable = true;
        minecraft.prism.enable = true;
        r2modman.enable = true;
        osu.enable = true;
      };
    };
  };
  jovian.decky-loader.enable = true;

  xdg.portal.enable = true;
  environment.sessionVariables.XDG_DESKTOP_PORTAL_DIR = "/run/current-system/sw/share/xdg-desktop-portal/portals";

  users.users.skye = {
    isNormalUser = true;
    description = "skye";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "skye";
  services.xserver.videoDrivers = [ "amdgpu" ];

  networking.firewall.allowedTCPPorts = [
    3000  # webdev server
    25565 # mc server stuff
    36123 # mc mekanism voice
  ];

  system.stateVersion = "23.11";
}
