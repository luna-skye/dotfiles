{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.apps.discord;
in {
  imports = [];


  options.bead.apps.discord = {
    enable = helpers.mkBooleanOption false "Whether to enable the Discord messaging client";
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.discord ];
  };
}
