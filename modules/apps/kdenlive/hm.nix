{ osConfig, pkgs, lib, ... }:


let
  hostCfg = osConfig.zen.apps.kdenlive;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.kdePackages.kdenlive ];
  };
}
