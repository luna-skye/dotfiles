{ config, lib, bead, pkgs, ... }: {
  imports = [];


  options.bead.apps.gaming = {};


  config = {
    programs.steam = lib.mkIf (bead.anyUserHasEnabled [ "bead" "apps" "gaming" "steam" "enable" ] config) {
      enable = lib.mkDefault true;
      remotePlay.openFirewall = lib.mkDefault true;
      gamescopeSession.enable = lib.mkDefault true;
    };

    environment.systemPackages = [
      ( # required for tf2
        lib.optional
        (bead.anyUserHasEnabled [ "bead" "apps" "gaming" "steam" "enable" ] config)
        pkgs.pkgsi686Linux.gperftools
      )

      ( # heroic games launcher
        lib.optional
        (bead.anyUserHasEnabled [ "bead" "apps" "gaming" "heroic" "enable" ] config)
        pkgs.heroic
      )
    ];

    # enable graphics layers with amdvlk
    #  TODO: This is AMD GPU specific, should be handled elsewhere and configurable
    hardware.graphics = lib.mkIf (false) {
      enable = lib.mkDefault true;
      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
  };
}
