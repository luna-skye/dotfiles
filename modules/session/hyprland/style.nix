{ inputs, config, lib, ... }:

let
  inherit (lib) mkDefault;

  stellae = inputs.stellae-nix.lib;
  colors = config.zen.theme.palette;

in {
  options.zen.session.hyprland = {};

  config = {
    wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = mkDefault 2;
        gaps_out = mkDefault 4;
        border_size = mkDefault 2;
        "col.active_border" = mkDefault "rgb(${stellae.colors.hslToRgb colors.primary}) rgb(${stellae.colors.hslToRgb colors.secondary}) 45deg";
        "col.inactive_border" = mkDefault "rgb(${stellae.colors.hslToRgb colors.surface.surface0}) rgb(${stellae.colors.hslToRgb colors.surface.surface0}) 45deg";
      };

      decoration = {
        rounding = mkDefault 12;
        active_opacity = mkDefault 0.95;
        inactive_opacity = mkDefault 0.9;
        fullscreen_opacity = mkDefault 1;
        shadow.range = mkDefault 32;
        shadow.render_power = mkDefault 4;
        blur = {
          enabled = mkDefault true;
          size = mkDefault 8;
          passes = mkDefault 2;
          xray = mkDefault false;
        };
        shadow.color = mkDefault "rgba(${stellae.colors.hslToRgb colors.surface.crust}99)";
      };

      animations = {
        enabled = mkDefault true;
        bezier = [
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "easeInOutCubic, 0.65, 0, 0.35, 1"
        ];
        animation = [
          "windows, 1, 1.5, smoothIn"
          "windowsOut, 1, 1.5, smoothIn"
          "border, 1, 2, smoothIn"

          "fade, 1, 1.4, easeInOutCubic"
          "fadeDim, 1, 1.5, easeInOutCubic"
          "workspaces, 1, 1.5, easeInOutCubic, slidevert"
        ];
      };

      misc = {
        disable_splash_rendering = mkDefault true;
        disable_hyprland_logo = mkDefault true;
      };
    };
  };
}
