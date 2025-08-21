{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.krita;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.krita ];
  };
}
