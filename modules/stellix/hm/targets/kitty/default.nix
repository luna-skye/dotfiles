{ config, lib, helpers, ... }: let
  cfg = config.bead.stellix.targets.kitty;
  colors = config.bead.stellix.palette;
in {
  imports = [];


  options.bead.stellix.targets.kitty = {
    enable = helpers.mkBooleanOption false "Whether to enable Kitty terminal emulator color overrides from STELLIX";

    enableColors = helpers.mkBooleanOption true "Whether to override Kitty's colors with STELLIX colors";
    enableFonts = helpers.mkBooleanOption true "Whether to override Kitty's fonts with STELLIX fonts";
  };


  config = lib.mkIf (config.bead.stellix.enable && cfg.enable) {
    programs.kitty = {
      # https://sw.kovidgoyal.net/kitty/conf/#color-scheme
      settings = lib.mkIf (cfg.enableColors) {
        background = lib.mkDefault colors.surface.mantle;
        foreground = lib.mkDefault colors.surface.subtext1;

        color0 = lib.mkDefault colors.surface.surface0;
        color8 = lib.mkDefault colors.surface.overlay0;
        color1  = lib.mkDefault colors.accent.red;
        color9  = lib.mkDefault colors.accent.lightRed;
        color3  = lib.mkDefault colors.accent.yellow;
        color11 = lib.mkDefault colors.accent.lightYellow;
        color2  = lib.mkDefault colors.accent.green;
        color10 = lib.mkDefault colors.accent.lightGreen;
        color4  = lib.mkDefault colors.accent.blue;
        color12 = lib.mkDefault colors.accent.lightBlue;
        color6  = lib.mkDefault colors.accent.purple;
        color14 = lib.mkDefault colors.accent.lightPurple;
        color5  = lib.mkDefault colors.accent.magenta;
        color13 = lib.mkDefault colors.accent.lightMagenta;
        color7  = lib.mkDefault colors.surface.subtext0;
        color15 = lib.mkDefault colors.surface.text;

        mark1_foreground = lib.mkDefault colors.surface.crust;
        mark1_background = lib.mkDefault colors.accent.lightGreen;
        mark2_foreground = lib.mkDefault colors.surface.crust;
        mark2_background = lib.mkDefault colors.accent.lightYellow;
        mark3_foreground = lib.mkDefault colors.surface.crust;
        mark3_background = lib.mkDefault colors.accent.lightRed;

        cursor = lib.mkDefault (lib.attrsets.attrByPath [ "accent" colors.primary ] "#FF0000" colors);
      };

      font = lib.mkIf (
        config.bead.stellix.fonts.enable &&
        cfg.enableFonts
      ) {
        name = lib.mkDefault config.bead.stellix.fonts.monospace.name;
        size = lib.mkDefault 12;
      };
    };
  };
}
