{ inputs, osConfig, config, lib, ... }:


let
  inherit (lib) mkDefault;
  hostCfg = osConfig.zen.services.dunst;

  stellae = inputs.stellae-nix.lib;
  colors = config.zen.theme.palette;

in {
  options.zen.services.dunst = {};

  config = lib.mkIf (hostCfg.enable) {
    services.dunst = {
      enable = mkDefault true;
      settings = {
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

        urgency_normal = {
          background = "#${stellae.colors.hslToHex colors.surface.mantle}";
          foreground = "#${stellae.colors.hslToHex colors.primary}";
          frame_color = "#${stellae.colors.hslToHex colors.primary}";
        };
        urgency_low = {
          background = "#${stellae.colors.hslToHex colors.surface.mantle}";
          foreground = "#${stellae.colors.hslToHex colors.surface.subtext0}";
          frame_color = "#${stellae.colors.hslToHex colors.surface.surface1}";
        };
        urgency_critical = {
          background = "#${stellae.colors.hslToHex colors.surface.mantle}";
          foreground = "#${stellae.colors.hslToHex colors.accent.light_red}";
          frame_color = "#${stellae.colors.hslToHex colors.accent.light_red}";
        };
      };
    };
  };
}
