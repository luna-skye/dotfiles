{ osConfig, lib, pkgs, ... }:

let
  hostCfg = osConfig.zen.apps.isoimagewriter;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.isoimagewriter ];
  };
}
