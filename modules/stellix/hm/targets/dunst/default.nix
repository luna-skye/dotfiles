{ config, lib, helpers, ... }: let
  cfg = config.bead.stellix.targets.dunst;
  colors = config.bead.stellix.palette;
in {
  imports = [];


  options.bead.stellix.targets.dunst = {
    enable = helpers.mkBooleanOption false "Whether to enable Dunst notification service styling through STELLIX";

    enableColors = helpers.mkBooleanOption true "Whether to use STELLIX colors for Dunst";
    enableFonts = helpers.mkBooleanOption true "Whether to use STELLIX fonts for Dunst";

    cornerRadius = helpers.mkNumberOption 0 "The amount in pixels to round Dunst notifications";
    borderWidth = helpers.mkNumberOption 2 "Width in pixels to render Dunst notification frames";
  };


  config = lib.mkIf (config.bead.stellix.enable && cfg.enable) {
    services.dunst.settings = let
      bg = "${colors.surface.mantle}D9";
      primaryColor = lib.attrsets.attrByPath [ "accent" colors.primary ] "#FF0000" colors;
    in {
      global = {
        corner_radius = lib.mkDefault cfg.cornerRadius;
        frame_width = lib.mkDefault cfg.borderWidth;
      } // (if cfg.enableFonts then {
        font = lib.mkDefault config.bead.stellix.fonts.monospace.name;
      } else {});
    } // (if cfg.enableColors then {
      urgency_normal = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault colors.surface.text;
        frame_color = lib.mkDefault primaryColor;
      };
      urgency_low = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault colors.surface.subtext0;
        frame_color = lib.mkDefault colors.surface.surface1;
      };
      urgency_critical = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault colors.accent.lightRed;
        frame_color = lib.mkDefault colors.accent.lightRed;
      };
    } else {});
  };
}
