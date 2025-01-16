{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.services.swww;
in {
  imports = [];


  options.bead.services.swww = {
    enable = helpers.mkBooleanOption false "Whether to enable the SWWW wallpaper daemon";
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.swww ];
  };
}
