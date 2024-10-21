{ config, lib, bead, ... }: let
  cfg = config.bead.plasma;
in {
  imports = [];


  options.bead.session.plasma = {
    enable = bead.mkBooleanOption false "Whether to enable the KDE Plasma Desktop Environment";
  };


  config = lib.mkIf (cfg.enable) {
    services.displayManager = {
      sddm = {
        enable = lib.mkDefault true;
        wayland.enable = lib.mkDefault true;
      };

      plasma6.enable = lib.mkDefault true;
    };
  };
}
