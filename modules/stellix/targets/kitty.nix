{ config, lib, ... }:
let
  cfg = config.theme.target.kitty;
  colors = config.theme.palette;
in {
  options.theme.target.kitty = {
    enable = lib.mkEnableOption "Enable theme targetting for Kitty";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty.settings = {
      # https://sw.kovidgoyal.net/kitty/conf/#color-scheme
      background = lib.mkDefault "#${colors.mantle}";
      foreground = lib.mkDefault "#${colors.subtext1}";

      color0  = lib.mkDefault "#${colors.surface0}";      # black
      color8  = lib.mkDefault "#${colors.overlay0}";      # dark gray
      color1  = lib.mkDefault "#${colors.red}";           # red
      color9  = lib.mkDefault "#${colors.light_red}";     # light red
      color3  = lib.mkDefault "#${colors.yellow}";        # yellow
      color11 = lib.mkDefault "#${colors.light_yellow}";  # light yellow
      color2  = lib.mkDefault "#${colors.green}";         # green
      color10 = lib.mkDefault "#${colors.light_green}";   # light green
      color4  = lib.mkDefault "#${colors.blue}";          # blue
      color12 = lib.mkDefault "#${colors.light_blue}";    # light blue
      color6  = lib.mkDefault "#${colors.purple}";        # cyan
      color14 = lib.mkDefault "#${colors.light_purple}";  # light cyan
      color5  = lib.mkDefault "#${colors.magenta}";       # magenta
      color13 = lib.mkDefault "#${colors.light_magenta}"; # light magenta
      color7  = lib.mkDefault "#${colors.subtext0}";      # dark white
      color15 = lib.mkDefault "#${colors.text}";          # white

      mark1_foreground = lib.mkDefault "#${colors.crust}";
      mark1_background = lib.mkDefault "#${colors.light_green}";
      mark2_foreground = lib.mkDefault "#${colors.crust}";
      mark2_background = lib.mkDefault "#${colors.light_yellow}";
      mark3_foreground = lib.mkDefault "#${colors.crust}";
      mark3_background = lib.mkDefault "#${colors.light_red}";

      cursor = lib.mkDefault "#${colors.accent_primary}";
    };

    programs.kitty.font = lib.mkIf config.theme.fonts.enable {
      name = lib.mkDefault config.theme.fonts.monospace.name;
      size = 12;
    };
  };
}
