{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.services.swww;

in {
  imports = [];
  options.zen.services.swww = {};
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.swww ];
  };
}
