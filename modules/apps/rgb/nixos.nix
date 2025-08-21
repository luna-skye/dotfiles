{ config, lib, helpers, pkgs, ... }:

let
  cfg = config.zen.apps.rgb;

in {
  imports = [];

  options.zen.apps.rgb = {
    enable = helpers.mkBooleanOption false "Whether to enable the OpenRGB application";
  };

  config = lib.mkIf (cfg.enable) {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
  };
}
