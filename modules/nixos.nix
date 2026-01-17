{ config, lib, helpers, ... }:

let
  inherit (lib) mkDefault mkForce;
  cfg = config.zen;

in {
  imports = helpers.getScopedSubmodules ../modules "nixos";

  options.zen = {
    host = {
      name = helpers.mkStringOption "hostName" "The host name for the NixOS system";
      timezone = helpers.mkStringOption "America/Indiana/Petersburg" "The timezone for the NixOS system";
    };
  };

  config = {
    # Configurable Options
    networking.hostName = mkDefault cfg.host.name;
    time.timeZone = mkDefault cfg.host.timezone;

    nixpkgs.hostPlatform = mkDefault "x86_64-linux";
    sops.age.keyFile = "/var/lib/sops-nix/keys.txt";

    # ---------------------------------------------
    # no ethical consumption under capitalism
    nixpkgs.config.allowUnfree = mkDefault true;

    # Experimental features which we rely on
    nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

    # Automatically hardlink of nix store paths to save hard disk space
    nix.settings.auto-optimise-store = mkDefault true;

    # Setup bootloader and systemd stuff
    boot.loader.systemd-boot.enable = mkDefault true;
    boot.loader.efi.canTouchEfiVariables = mkDefault true;

    # Limit old generation count on bootloader
    boot.loader.systemd-boot.configurationLimit = mkDefault 10;

    # Force disable emergency mode, it's deadlocked NixOS systems for me in the past
    # systemd.enableEmergencyMode = mkForce false;

    # XServer & XKB
    services.xserver.enable = mkDefault true;
    services.xserver.xkb = {
      layout = mkDefault "us";
      variant = mkDefault "";
    };

    # Internationalisation
    i18n.defaultLocale =  mkDefault "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS        = mkDefault "en_US.UTF-8";
      LC_IDENTIFICATION = mkDefault "en_US.UTF-8";
      LC_MEASUREMENT    = mkDefault "en_US.UTF-8";
      LC_MONETARY       = mkDefault "en_US.UTF-8";
      LC_NAME           = mkDefault "en_US.UTF-8";
      LC_NUMERIC        = mkDefault "en_US.UTF-8";
      LC_PAPER          = mkDefault "en_US.UTF-8";
      LC_TELEPHONE      = mkDefault "en_US.UTF-8";
      LC_TIME           = mkDefault "en_US.UTF-8";
    };
  };
}
