{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.anki;
in {
  imports = [];
  options.zen.apps.anki = {};
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.anki ];
  };
}
