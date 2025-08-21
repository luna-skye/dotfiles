{ inputs, config, lib, pkgs, helpers, ... }:

let
  cfg = config.zen.session.plasma;

in {
  imports = [];

  options.zen.session.plasma = {
    enable = helpers.mkBooleanOption false "Whether to enable the KDE Plasma Desktop Environment";
  };

  config = lib.mkIf (cfg.enable) {
    services.displayManager.sddm = {
      enable = lib.mkDefault true;
      wayland.enable = lib.mkDefault true;
    };
    services.desktopManager.plasma6.enable = lib.mkDefault true;
    environment.systemPackages = [
      pkgs.kde-rounded-corners
      inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    ];
  };
}
