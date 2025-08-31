{ config, lib, helpers, pkgs, ... }:

let
  cfg = config.zen.apps.gaming;

in {
  options.zen.apps.gaming = {
    enable = helpers.mkBooleanOption false "Whether to enable ANY gaming related packages";
    useAMDVLK = helpers.mkBooleanOption false "Whether to use AMDVLK drivers instead of MESA provided ones";

    gamemode.enable = helpers.mkBooleanOption true "Whether to install Feral Gamemode";
    steam.enable = helpers.mkBooleanOption true "Whether to enable the Steam gaming platform";
    heroic.enable = helpers.mkBooleanOption false "Whether to enable the Heroic gaming platform, for Epic Games content";
    lutris.enable = helpers.mkBooleanOption false "Whether to enable the Lutris gaming application";
    r2modman.enable = helpers.mkBooleanOption false "Whether to enable the r2modman mod manager";

    minecraft = {
      modrinth.enable = helpers.mkBooleanOption false "Whether to enable the Modrinth Minecraft launcher";
      atl.enable = helpers.mkBooleanOption false "Whether to enable the ATLauncher Minecraft launcher";
      prism.enable = helpers.mkBooleanOption false "Whether to enable the Prism Launcher";
    };
  };

  config = lib.mkIf (cfg.enable) {
    programs.steam = lib.mkIf (cfg.steam.enable) {
      enable = lib.mkDefault true;
      remotePlay.openFirewall = lib.mkDefault true;
      gamescopeSession.enable = lib.mkDefault true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    environment.systemPackages = let
      inherit (lib.lists) optional;
    in 
      optional (cfg.steam.enable)  pkgs.pkgsi686Linux.gperftools ++ # required for tf2
      optional (cfg.heroic.enable) pkgs.heroic ++
      [];

    programs.gamemode.enable = cfg.gamemode.enable;

    # enable graphics layers with amdvlk
    hardware.graphics = lib.mkIf (true) {
      enable = lib.mkDefault true;
      extraPackages = lib.lists.optionals (cfg.useAMDVLK) [ pkgs.amdvlk ];
      extraPackages32 = lib.lists.optionals (cfg.useAMDVLK) [ pkgs.driversi686Linux.amdvlk ];
    };
  };
}
