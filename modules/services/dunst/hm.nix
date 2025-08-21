{ osConfig, lib, ... }:

let
  inherit (lib) mkDefault;
  hostCfg = osConfig.zen.services.dunst;

in {
  imports = [];
  options.zen.services.dunst = {};
  config = lib.mkIf (hostCfg.enable) {
    # TODO: Move style options to the stellix themeing module
    services.dunst = {
      enable = mkDefault true;
      settings.global = {
        origin = mkDefault "top-right";
        monitor = mkDefault "1";
        width = mkDefault 320;
        height = mkDefault 160;
        offset = mkDefault "32x32";
        corner-radius = mkDefault 0;
        frame_width = mkDefault 2;
        font = mkDefault "Noto Sans 10";
        progress_bar = mkDefault true;
        sort = mkDefault "yes";
      };
    };
  };
}
