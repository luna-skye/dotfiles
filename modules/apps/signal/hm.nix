{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.signal;

in {
  imports = [];
  options.zen.apps.signal = {};
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.signal-desktop ];
  };
}
