{ config, lib, helpers, ... }: let
  cfg = config.bead.stellix.targets.hyprland;
  colors = config.bead.stellix.palette;
in {
  imports = [];


  options.bead.stellix.targets.hyprland = {
    enable = helpers.mkBooleanOption false "Whether to style Hyprland automatically through STELLIX";

    cornerRadius = helpers.mkNumberOption 0 "The amount in pixels to round window corners";

    gaps = {
      inner = helpers.mkNumberOption 8 "Number of pixels between tiled windows";
      outer = helpers.mkNumberOption 16 "Number of pixels between windows and monitor edge";
      workspaces = helpers.mkNumberOption 0 "Number of pixels between workspaces";
    };

    border = {
      size = helpers.mkNumberOption 2 "Size of window borders in pixels";

      gradient = {
        enable = helpers.mkBooleanOption true "Whether to configure window border colors as gradients";
        angle = helpers.mkNumberOption 45 "The angle to render window border gradients with";
      };
    };

    opacity = {
      active = helpers.mkNumberOption 0.95 "The opacity of active windows";
      inactive = helpers.mkNumberOption 0.9 "The opacity of inactive windows";
      fullscreen = helpers.mkNumberOption 1 "The opacity of fullscreen windows";
    };

    blur = {
      enable = helpers.mkBooleanOption true "Whether to enable blurring behind windows";

      size = helpers.mkNumberOption 8 "The size of blur to apply, in pixels";
      noise = helpers.mkNumberOption 0 "The amount of noise grain to add to the blur [0.0 - 1.0]";
      brightness = helpers.mkNumberOption 0.82 " [0.0 - 2.0]";
      contrast = helpers.mkNumberOption 0.9 " [0.0 - 2.0]";
      vibrancy = helpers.mkNumberOption 0.18 " [0.0 - 1.0]";
      vibrancyDark = helpers.mkNumberOption 0.18 " [0.0 - 1.0]";

      xray = helpers.mkBooleanOption true "Whether blur should ignore stacked windows";
    };

    animations = {
      enable = helpers.mkBooleanOption true "Whether to enable animations in Hyprland";
      enableDefaultAnimations = helpers.mkBooleanOption true "Whether to enable default preconfigured animations";

      extraBezier = helpers.mkListOfOption lib.types.str [] "Extra bezier curves to register";
      extraAnimation = helpers.mkListOfOption lib.types.str [] "Extra animation rules to register";
    };
  };


  config = lib.mkIf (config.bead.stellix.enable && cfg.enable) {
    wayland.windowManager.hyprland.settings = let
      colPrimary = lib.attrsets.attrByPath [ "accent" colors.primary ] "#FF0000" colors;
      colSecondary = lib.attrsets.attrByPath [ "accent" colors.secondary ] "#FF0000" colors;

      activeBorder = if (cfg.border.gradient.enable)
        then "rgb(${colPrimary}) rgb(${colSecondary}) ${builtins.toString cfg.border.gradient.angle}deg" 
        else "rgb(${colPrimary})";
      inactiveBorder = if (cfg.border.gradient.enable) 
        then "rgb(${colors.surface.overlay1}) rgb(${colors.surface.overlay0}) ${builtins.toString cfg.border.gradient.angle}deg" 
        else "rgb(${colors.surface.overlay1})";
    in {
      general = {
        gaps_in = lib.mkDefault cfg.gaps.inner;
        gaps_out = lib.mkDefault cfg.gaps.outer;
        gaps_workspaces = lib.mkDefault cfg.gaps.workspaces;

        border_size = lib.mkDefault cfg.border.size;
        "col.active_border" = lib.mkDefault activeBorder;
        "col.inactive_border" = lib.mkDefault inactiveBorder;
      };

      decoration = {
        rounding = lib.mkDefault cfg.cornerRadius;

        active_opacity = lib.mkDefault cfg.opacity.active;
        inactive_opacity = lib.mkDefault cfg.opacity.inactive;
        fullscreen_opacity = lib.mkDefault cfg.opacity.fullscreen;

        shadow_range = lib.mkDefault 32;
        shadow_render_power = lib.mkDefault 4;
        "col.shadow" = lib.mkDefault "rgba(${colors.surface.crust}99)";

        blur = {
          enabled = lib.mkDefault cfg.blur.enable;
          
          size = lib.mkDefault cfg.blur.size;
          noise = lib.mkDefault cfg.blur.noise;
          
          brightness = lib.mkDefault cfg.blur.brightness;
          contrast = lib.mkDefault cfg.blur.contrast;
          vibrancy = lib.mkDefault cfg.blur.vibrancy;
          vibrancy_darkness = lib.mkDefault cfg.blur.vibrancyDark;

          xray = lib.mkDefault cfg.blur.xray;

          passes = lib.mkDefault 2;
        };
      };

      animations = let
        inherit (lib.lists) optionals;

        bezier = optionals (cfg.animations.enableDefaultAnimations) [
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "easeInOutCubic, 0.65, 0, 0.35, 1"
        ] ++ cfg.animations.extraBezier;

        animation = optionals (cfg.animations.enableDefaultAnimations) [
          "windows, 1, 1.5, smoothIn"
          "windowsOut, 1, 1.5, smoothIn"
          "border, 1, 2, smoothIn"

          "fade, 1, 1.4, easeInOutCubic"
          "fadeDim, 1, 1.5, easeInOutCubic"
          "workspaces, 1, 1.5, easeInOutCubic, slidevert"
        ] ++ cfg.animations.extraAnimation;
      in {
        enable = lib.mkDefault cfg.animations.enable;
        bezier = lib.mkDefault bezier;
        animation = lib.mkDefault animation;
      };

      misc = {
        disable_hyprland_logo = lib.mkDefault true;
        disable_splash_rendering = lib.mkDefault true;
      };
    };
  };
}
