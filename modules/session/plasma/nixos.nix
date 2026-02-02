{ config, lib, pkgs, helpers, ... }:


let
  cfg = config.zen.session.plasma;

in {
  imports = [];

  options.zen.session.plasma = {
    enable = helpers.mkBooleanOption false "Whether to enable the KDE Plasma Desktop Environment";
    useSDDM = helpers.mkBooleanOption true "Whether to enable and use the SDDM Display Manager";
  };

  config = lib.mkIf (cfg.enable) {
    services.displayManager.sddm = {
      enable = lib.mkDefault cfg.useSDDM;
      wayland.enable = lib.mkDefault true;
    };
    services.desktopManager.plasma6.enable = lib.mkDefault true;
    environment.systemPackages = [
      pkgs.kde-rounded-corners
    ];
  };
}
