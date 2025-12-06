{ osConfig, pkgs, lib, ... }:


let
  hostCfg = osConfig.zen.apps.chromium;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.ungoogled-chromium ];
  };
}
