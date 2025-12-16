{ osConfig, config, lib, stellae, ... }:


let
  inherit (lib) mkDefault;
  hostCfg = osConfig.zen.services.dunst;

  colors = config.zen.theme.element;

in {
  options.zen.services.dunst = {};

  config = lib.mkIf (hostCfg.enable) {
    services.dunst = {
      enable = mkDefault true;
      settings = stellae.exporters.dunst.hmOptions { element = config.zen.theme.element; } // {
        global = {
          origin = mkDefault "top-right";
          monitor = mkDefault "1";

          width = mkDefault 320;
          height = mkDefault 160;
          offset = mkDefault "32x32";

          font = mkDefault "Noto Sans 10";
          corner-radius = mkDefault 0;
          frame_width = mkDefault 2;
          progress_bar = mkDefault true;
          sort = mkDefault "yes";
        };
      };
    };
  };
}
