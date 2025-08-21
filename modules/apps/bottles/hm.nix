{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.bottles;

in {
  imports = [];
  options.zen.apps.bottles = {};
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.bottles ];
  };
}
