{ osConfig, pkgs, lib }:

let
  osCfg = osConfig.zen.apps.figma-linux;

in {
  config = lib.mkIf (osCfg.enable) {
    home.packages = [ pkgs.figma-linux ];
  };
}
