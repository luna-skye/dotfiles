{ config, lib, helpers, pkgs, ... }: {
  imports = [];


  options.bead.apps.gaming = {};


  config = let
    enableSteam  = helpers.anyUserHasEnabled [ "bead" "apps" "gaming" "steam"  "enable" ] config;
    enableHeroic = helpers.anyUserHasEnabled [ "bead" "apps" "gaming" "heroic" "enable" ] config;
  in lib.mkIf (helpers.anyUserHasEnabled [ "bead" "apps" "gaming" "enable" ] config) {
    programs.steam = lib.mkIf (enableSteam) {
      enable = lib.mkDefault true;
      remotePlay.openFirewall = lib.mkDefault true;
      gamescopeSession.enable = lib.mkDefault true;
    };

    environment.systemPackages = let
      inherit (lib.lists) optional;
    in 
      optional (enableSteam)  pkgs.pkgsi686Linux.gperftools ++ # required for tf2
      optional (enableHeroic) pkgs.heroic ++
      [];

    # enable graphics layers with amdvlk
    #  TODO: This is AMD GPU specific, should be handled elsewhere and configurable
    hardware.graphics = lib.mkIf (false) {
      enable = lib.mkDefault true;
      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
  };
}
