{ osConfig, pkgs, lib, ... }:

let
  osCfg = osConfig.zen.apps.aseprite;

in {
  #  TODO: Grab and symlink some themes from Github
  config = lib.mkIf (osCfg) {
    home.packages = [ pkgs.aseprite ];
  };
}
