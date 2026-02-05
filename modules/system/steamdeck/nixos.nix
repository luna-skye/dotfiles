{ config, lib, helpers, ... }:


let
  inherit (lib) mkDefault;
  cfg = config.zen.system.steamdeck;

in {
  options.zen.system.steamdeck = {
    enable = helpers.mkBooleanOption false "Whether to use Steam Deck configuration for this device";
    username = helpers.mkStringOption "steamos" "The username to register for Steam";
  };

  config = lib.mkIf (cfg.enable) {
    boot.loader = {
      timeout = mkDefault 0;
      limine.maxGenerations = mkDefault 5;
    };
    boot.kernelParams = [
      # Disable wifi 6ghz
      "cfg80211.ieee80211_regdom=00"
      "iwlwifi.lar_disable=1"
    ];
    boot.kernel.sysctl = {
      "kernel.split_lock_mitigate" = 0;
      "kernel.nmi_watchdog" = 0;
      "kernel.sched_bore" = "1";
    };
    boot.initrd = {
      systemd.enable = mkDefault true;
      kernelModules = mkDefault [];
    };
    systemd.settings.Manager.DefaultTimeoutStepSec = mkDefault "5s";
    hardware.amdgpu.initrd.enable = mkDefault false;

    networking = {
      hostName = config.zen.host.name;
      networkmanager.enable = mkDefault true;
    };

    hardware.bluetooth = {
      enable = mkDefault true;
      settings = {
        General = {
          MultiProfile = "multiple";
          FastConnectable = true;
        };
      };
    };

    environment.sessionVariables = {
      PROTON_USE_NTSYNC = "1";
      ENABLE_HDR_WSI = "1";
      DXVK_HDR = "1";
      PROTON_ENABLE_AMD_AGS = "1";
      PROTON_ENABLE_NVAPI = "1";
      ENABLE_GAMESCOPE_WSI = "1";
      STEAM_MULTIPLE_XWAYLANDS = "1";
    };
    zramSwap = {
      enable = mkDefault true;
      algorithm = mkDefault "zstd";
    };
    services.automatic-timezoned.enable = mkDefault true;


    services.flatpak.enable = mkDefault true;
    programs.appimage = {
      enable = mkDefault true;
      binfmt = mkDefault true;
    };


    zen = {
      session = {
        default = mkDefault "plasma";
        plasma.enable = mkDefault true;
        plasma.useSDDM = mkDefault false;

        # preconfigure monitors for window managers if used
        monitors = mkDefault [{
          name        = "eDP-1";
          resolution  = "1280x800";
          offset      = "0x0";
          refreshRate = 90;
        }];
      };
      security = {
        apparmor.enable = false;
        setKernelParams = false;
        setSysctlTweaks = false;
        blacklistKernelModules = false;
        disableCoreDumps = false;
      };
    };

    jovian = {
      hardware.has.amd.gpu = mkDefault true;
      devices.steamdeck.enable = mkDefault true;

      steam.enable = mkDefault true;
      steam.autoStart = mkDefault true;
      steam.user = mkDefault config.zen.system.steamdeck.username;
      steamos.useSteamOSConfig = mkDefault true;
      steam.desktopSession = mkDefault config.zen.session.default;
      decky-loader.enable = mkDefault true;
    };

    # create cef file for decky
    systemd.user.tmpfiles.rules = lib.mkIf config.jovian.decky-loader.enable [
      "f /home/${config.jovian.steam.user}/.local/share/Steam/.cef-enable-remote-debugging 0644 ${config.jovian.steam.user} users -"
    ];
  };
}
