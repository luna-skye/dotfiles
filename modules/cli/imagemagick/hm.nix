{ osConfig, pkgs, lib, ... }:

let
  osCfg = osConfig.zen.cli.imagemagick;

in {
  config = lib.mkIf (osCfg.enable) {
    home.packages = [ pkgs.imagemagick ];
  };
}
