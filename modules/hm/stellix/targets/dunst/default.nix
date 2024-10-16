{ config, lib, bead, ... }: let
  cfg = config.bead.stellix.targets.dunst;
  colors = config.bead.stellix.palette;
in {
  imports = [];


  options.bead.stellix.targets.dunst = {
    enable = bead.mkBooleanOption false "Whether to enable Dunst notification service styling through STELLIX";

    cornerRadius = bead.mkNumberOption 0 "The amount in pixels to round Dunst notifications";
    borderWidth = bead.mkNumberOption 2 "Width in pixels to render Dunst notification frames";
  };


  config = lib.mkIf (
    config.bead.stellix.enable &&
    cfg.enable
  ) {
    services.dunst.settings = let
      bg = "${colors.surface.mantle}D9";
    in {
      global = {
        corner_radius = lib.mkDefault cfg.cornerRadius;
        frame_width = lib.mkDefault cfg.borderWidth;
      };

      urgency_normal = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault colors.surface.text;
        frame_color = lib.mkDefault lib.attrsets.attrByPath [ "accent" colors.primary ] "#FF0000" colors;
      };
      urgency_low = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault colors.subtext0;
        frame_color = lib.mkDefault colors.surface1;
      };
      urgency_critical = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault colors.error;
        frame_color = lib.mkDefault colors.error;
      };
    };
  };
}
