{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.discord;

in {
  imports = [];
  options.zen.apps.discord = {};
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.discord ];
  };
}
