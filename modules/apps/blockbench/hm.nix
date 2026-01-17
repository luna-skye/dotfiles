{ osConfig, pkgs, lib, ... }:

let
  osCfg = osConfig.zen.apps.blockbench;

in {
  config = lib.mkIf (osCfg.enable) {
    home.packages = [ pkgs.blockbench ];
  };
}
