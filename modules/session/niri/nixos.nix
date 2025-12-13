{ config, lib, helpers, pkgs, ... }:


let
  cfg = config.zen.session.niri;

in {
  options.zen.session.niri = {
    enable = helpers.mkBooleanOption false "Whether to install the Niri window manager";
  };

  config = lib.mkIf (cfg.enable) {
    programs.niri.enable = true;

    environment.systemPackages = [
      pkgs.xwayland-satellite
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
    };
  };
}
