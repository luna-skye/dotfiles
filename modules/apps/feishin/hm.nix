{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.feishin;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.feishin ];
  };
}
