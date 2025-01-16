{ config, lib, helpers, ... }: let
  cfg = config.bead.session.plasma;
in {
  imports = [];


  options.bead.session.plasma = {
    enable = helpers.mkBooleanOption false "Whether to enable the KDE Plasma Desktop Environment";
  };


  config = lib.mkIf (cfg.enable) {
    services.displayManager.sddm = {
      enable = lib.mkDefault true;
      wayland.enable = lib.mkDefault true;
    };
    services.desktopManager.plasma6.enable = lib.mkDefault true;
  };
}
