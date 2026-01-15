{ config, pkgs, lib, helpers, ... }:


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
      systemd-boot.enable = mkDefault true;
      efi.canTouchEfiVariables = mkDefault true;
      timeout = mkDefault 0;
      limine.maxGenerations = mkDefault 5;
    };
    boot.kernelParams = [ "quiet" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernel.sysctl = {
      "kernel.split_lock_mitigate" = 0;
      "kernel.nmi_watchdog" = 0;
      "kernel.sched_bore" = "1";
    };
    boot.initrd = {
      systemd.enable = mkDefault true;
      kernelModules = mkDefault [];
      verbose = mkDefault false;
    };
    boot.plymouth.enable = mkDefault true;
    boot.consoleLogLevel = mkDefault 0;
    systemd.settings.Manager.DefaultTimeoutStepSec = mkDefault "5s";
    hardware.amdgpu.initrd.enable = mkDefault false;

    fileSystems."/" = {
      options = [ "compress=zstd" ];
    };

    networking = {
      networkmanager.enable = mkDefault true;
      firewall.enable = mkDefault false;
      hostName = config.zen.host.name;
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
    services.automatic-timzoned.enable = mkDefault true;


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
      steam.enable = mkDefault true;
      steam.autoStart = mkDefault true;
      steam.user = mkDefault config.zen.system.steamdeck.username;
      decky-loader.enable = mkDefault true;
      steamos.useSteamOSConfig = mkDefault true;
      steam.desktopSession = mkDefault config.zen.session.default;
      hardware.has.amd.gpu = true;
    };

    # Create Steam CEF debugging file if it doesn't exist so Decky loads correctly
    # Thanks to: https://github.com/Jovian-Experiments/Jovian-NixOS/issues/460#issuecomment-3439375088
    systemd.services.steam-cef-debug = lib.mkIf (config.jovian.decky-loader.enable) {
      description = "Create Steam CEF debugging file";
      serviceConfig = {
        type = "oneshot";
        User = config.jovian.steam.user;
        ExecStart = "/bin/sh -c 'mkdir -p ~/.steam/steam && [ ! -f ~/.steam/steam/.cef-enable-remote-debugging ] && touch ~/.steam/steam/.cef-enable-remote-debugging || true'";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
