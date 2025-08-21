{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.komikku;

in {
  imports = [];
  options.zen.apps.komikku = {};
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.komikku ];
  };
}

