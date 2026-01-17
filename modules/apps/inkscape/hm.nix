{ osConfig, pkgs, lib, ... }:

let
  osCfg = osConfig.zen.apps.inkscape;

in {
  config = lib.mkIf (osCfg.enable) {
    home.packages = [ pkgs.inkscape ];
  };
}
