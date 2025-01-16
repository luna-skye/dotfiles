{ config, lib, helpers, ... }: let
  cfg = config.bead;
in {
  imports = helpers.getScopedSubmodules ../modules "nix";


  options.bead = {
    host = {
      name = helpers.mkStringOption "hostName" "The host name for the NixOS system";
      timezone = helpers.mkStringOption "America/Indiana/Petersburg" "The timezone for the NixOS system";
    };

    extraPkgs = helpers.mkListOfOption lib.types.package [] "Extra packages to install globally onto the system. Prefer the user option in most cases.";
  };


  config = {
    # Configurable Options
    networking.hostName = lib.mkDefault cfg.host.name;
    time.timeZone = lib.mkDefault cfg.host.timezone;

    environment.systemPackages = cfg.extraPkgs;

    # ---------------------------------------------
    # no ethical consumption under capitalism
    nixpkgs.config.allowUnfree = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    # Experimental features which we rely on
    nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

    # Setup bootloader and systemd stuff
    boot.loader.systemd-boot.enable = lib.mkDefault true;
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

    # Limit old generation count on bootloader
    boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;

    # Force disable emergency mode, it's deadlocked NixOS systems for me in the past
    systemd.enableEmergencyMode = lib.mkForce false;

    # Networking
    #  TODO: maybe move this to its own config with options
    networking.networkmanager.enable = lib.mkDefault true;
    # networking.wireless.enable = lib.mkDefault true;

    # XServer & XKB
    services.xserver.enable = lib.mkDefault true;
    services.xserver.xkb = {
      layout = lib.mkDefault "us";
      variant = lib.mkDefault "";
    };

    # Internationalisation
    i18n.defaultLocale =  lib.mkDefault "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS        = lib.mkDefault "en_US.UTF-8";
      LC_IDENTIFICATION = lib.mkDefault "en_US.UTF-8";
      LC_MEASUREMENT    = lib.mkDefault "en_US.UTF-8";
      LC_MONETARY       = lib.mkDefault "en_US.UTF-8";
      LC_NAME           = lib.mkDefault "en_US.UTF-8";
      LC_NUMERIC        = lib.mkDefault "en_US.UTF-8";
      LC_PAPER          = lib.mkDefault "en_US.UTF-8";
      LC_TELEPHONE      = lib.mkDefault "en_US.UTF-8";
      LC_TIME           = lib.mkDefault "en_US.UTF-8";
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?
  };
}
