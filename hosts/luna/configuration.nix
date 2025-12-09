{ ... }:

{
  zen = {
    host.name = "luna";
    # ups.enable = true;
    system = {
      kernel.useCachy = true;
      fan2go = {
        enable = true;
        settings = import ./fans.nix;
      };
    };

    benchmarks.enable = true;

    session = {
      default = "plasma";
      plasma.enable = true;
      hyprland = {
        enable = false;
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
    };

    apps = {
      zen-browser.enable = true;
      chromium.enable = true;
      obsidian.enable = true;
      rgb.enable = true;
      gaming = {
        enable = true;
        lutris.enable = true;
        minecraft.atl.enable = true;
        minecraft.prism.enable = true;
        r2modman.enable = true;
      };
      media = {
        image.oculante.enable = true;
        video.vlc.enable = true;
        video.mpv.enable = true;
        audio.elisa.enable = true;
      };
      feishin.enable = true;
      bottles.enable = true;
      krita.enable = true;
      blender.enable = true;
      davinci-resolve.enable = true;
      godot.enable = true;
      idea.enable = true;
      unityhub.enable = false;
      daw.enable = true;
      discord.enable = true;
      signal.enable = true;
      mumble.enable = true;
      anki.enable = true;
      komikku.enable = true;
      obs.enable = true;
    };
  };

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
}
