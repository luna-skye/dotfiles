{ config, lib, ... }:

let
  inherit (lib) mkDefault;
  cfg = config.theme.target.hyprland;
  colors = config.theme.palette;

in {
  options.theme.target.hyprland = {
    enable = lib.mkEnableOption "Enable color palette targeting for Hyprland";
  };

  config = lib.mkIf (cfg.enable) {
    wayland.windowManager.hyprland.settings = {
      general = {
        "col.active_border" = mkDefault "rgb(${colors.accent_primary}) rgb(${colors.accent_secondary}) 45deg";
        "col.inactive_border" = mkDefault "rgb(${colors.surface1}) rgb(${colors.surface0}) 45deg";
      };

      decoration = {
        shadow.color = mkDefault "rgba(${colors.crust}99)";
      };

      plugin = {
        hyprbars = {
          "col.text" = mkDefault "rgb(${colors.subtext0})";
          bar_color = mkDefault "rgb(${colors.crust})";
          bar_text_size = mkDefault 10;
          bar_text_font = mkDefault "JetBrains Mono Nerd Font";
          bar_button_padding = 12;
          bar_padding = 10;
          bar_precedence_over_border = true;

          hyprbars-button = let
            button = icon: col: size: cmd: "rgb(${col}), ${toString size}, ${icon}, ${cmd}";
          in [
            ( button "" "${colors.red}" 20 "hyprctl dispatch killactive" ) # kill
            ( button "" "${colors.yellow}" 20 "hyprctl dispatch fullscreen 2" ) # min/max
            ( button "" "${colors.surface0}" 20 "hyprctl dispatch togglefloating" ) # toggle float
          ];
        };
      };
    };
  };
}
