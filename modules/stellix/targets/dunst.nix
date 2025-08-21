{ config, lib, ... }:

let
  cfg = config.theme.target.dunst;
  colors = config.theme.palette;
  bg = "#${colors.mantle}D9";

in {
  options.theme.target.dunst = {
    enable = lib.mkEnableOption "Enable color palette for dunst";
  };

  config = lib.mkIf cfg.enable {
    services.dunst.settings = {
      urgency_normal = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault "#${colors.text}";
        frame_color = lib.mkDefault "#${colors.accent_primary}";
      };
      urgency_low = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault "#${colors.subtext0}";
        frame_color = lib.mkDefault "#${colors.surface1}";
      };
      urgency_critical = {
        background = lib.mkDefault bg;
        foreground = lib.mkDefault "#${colors.error}";
        frame_color = lib.mkDefault "#${colors.error}";
      };
    };
  };
}
