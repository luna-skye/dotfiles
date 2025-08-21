{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.kdeconnect;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.kdePackages.kdeconnect-kde ];
  };
}
