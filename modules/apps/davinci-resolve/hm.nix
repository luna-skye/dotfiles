{ osConfig, pkgs, lib, ... }:


let
  hostCfg = osConfig.zen.apps.davinci-resolve;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.davinci-resolve ];
  };
}
