{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.apps.discord;
in {
  imports = [];


  options.bead.apps.discord = {
    enable = bead.mkBooleanOption false "Whether to enable the Discord messaging client";
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.discord ];
  };
}
