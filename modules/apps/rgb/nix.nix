{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.apps.rgb;
in {
  imports = [];


  options.bead.apps.rgb = {
    enable = helpers.mkBooleanOption false "Whether to enable the OpenRGB application";
  };


  config = lib.mkIf (cfg.enable) {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
  };
}
