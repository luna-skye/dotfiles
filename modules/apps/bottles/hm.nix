{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.apps.bottles;
in {
  imports = [];


  options.bead.apps.bottles = {
    enable = helpers.mkBooleanOption false "Whether to enable the Bottle Wine manager";
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.bottles ];
  };
}
