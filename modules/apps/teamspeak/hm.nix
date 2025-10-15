{ osConfig, lib, pkgs, ... }:


let
  hostCfg = osConfig.zen.apps.teamspeak;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.teamspeak6-client ];
  };
}
