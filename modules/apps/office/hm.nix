{ osConfig, pkgs, lib, ... }:

let
  inherit (lib) mkDefault;
  hostCfg = osConfig.zen.apps.office;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ pkgs.libreoffice-qt ];
  };
}
