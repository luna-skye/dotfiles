{ config, osConfig, lib, bead, ... }: let
  cfg = config.bead.services.dunst;
  osCfg = osConfig.bead.services.dunst;
in {
  imports = [];


  options.bead.services.dunst = {
    enable = bead.mkBooleanOption false "Whether to enable the Dunst notification daemon";
  };


  config = lib.mkIf (cfg.enable) {
    services.dunst = {
      enable = lib.mkDefault true;

      settings.global = {
        origin = lib.mkDefault osCfg.anchor;
        monitor = lib.mkDefault osCfg.monitorIdx;

        width = lib.mkDefault 320;
        height = lib.mkDefault 160;
        offset = lib.mkDefault "32x32";

        progress_bar = lib.mkDefault true;
        sort = lib.mkDefault "yes";
      };
    };
  };
}
