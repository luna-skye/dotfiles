{ config, lib, bead, pkgs, ... }: {
  imports = [];


  options.bead.apps.rgb = {};


  config = lib.mkIf (bead.anyUserHasEnabled [ "bead" "apps" "rgb" "enable" ] config) {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
  };
}
