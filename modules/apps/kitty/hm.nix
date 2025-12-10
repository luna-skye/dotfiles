{ inputs, config, lib, ... }:


let
  inherit (lib) mkDefault;

  stellae = inputs.stellae-nix.lib;
  colors = config.zen.theme.palette;

in {
  programs.kitty = {
    enable = mkDefault true;
    themeFile = mkDefault "Catppuccin-Mocha";

    settings = {
      scrollback_lines = mkDefault 10000;
      enable_audio_bell = mkDefault false;
      update_check_interval = mkDefault 0;

      scrollback_fill_enlarged_window = mkDefault "yes";
      mouse_hide_wait = mkDefault 1;

      remember_window_size = mkDefault "no";
      initial_window_width = mkDefault 1280;
      initial_window_height = mkDefault 720;
      window_margin_width = mkDefault 2;

      cursor_trail = mkDefault 1;

      # theme
      background = mkDefault "#${stellae.colors.hslToHex colors.surface.mantle}";
      foreground = mkDefault "#${stellae.colors.hslToHex colors.surface.subtext1}";

      color0 = mkDefault "#${stellae.colors.hslToHex colors.surface.subtext0}";
      color8 = mkDefault "#${stellae.colors.hslToHex colors.surface.overlay0}";
      color7 = mkDefault "#${stellae.colors.hslToHex colors.surface.subtext0}";
      color15 = mkDefault "#${stellae.colors.hslToHex colors.surface.text}";

      color1 = mkDefault "#${stellae.colors.hslToHex colors.accent.red}";
      color9 = mkDefault "#${stellae.colors.hslToHex colors.accent.light_red}";
      color3 = mkDefault "#${stellae.colors.hslToHex colors.accent.yellow}";
      color11 = mkDefault "#${stellae.colors.hslToHex colors.accent.light_yellow}";
      color2 = mkDefault "#${stellae.colors.hslToHex colors.accent.green}";
      color10 = mkDefault "#${stellae.colors.hslToHex colors.accent.light_green}";
      color4 = mkDefault "#${stellae.colors.hslToHex colors.accent.blue}";
      color12 = mkDefault "#${stellae.colors.hslToHex colors.accent.light_blue}";
      color6 = mkDefault "#${stellae.colors.hslToHex colors.accent.purple}";
      color14 = mkDefault "#${stellae.colors.hslToHex colors.accent.light_purple}";
      color5 = mkDefault "#${stellae.colors.hslToHex colors.accent.magenta}";
      color13 = mkDefault "#${stellae.colors.hslToHex colors.accent.light_magenta}";

      mark1_foreground = mkDefault "#${stellae.colors.hslToHex colors.surface.crust}";
      mark1_background = mkDefault "#${stellae.colors.hslToHex colors.accent.light_green}";
      mark2_foreground = mkDefault "#${stellae.colors.hslToHex colors.surface.crust}";
      mark2_background = mkDefault "#${stellae.colors.hslToHex colors.accent.light_yellow}";
      mark3_foreground = mkDefault "#${stellae.colors.hslToHex colors.surface.crust}";
      mark3_background = mkDefault "#${stellae.colors.hslToHex colors.accent.light_red}";

      cursor = mkDefault "#${stellae.colors.hslToHex colors.primary}";
    };

    font = lib.mkIf (config.zen.theme.fonts.enable) {
      name = mkDefault config.zen.theme.fonts.monospace.name;
      size = 12;
    };

    extraConfig = ''
    modify_font underline_position 4
    modify_font underline_thickness 150%
    modify_font strikethrough_position 3px
    modify_font cell_height +4px

    disable_ligatures cursor
    '';
  };
}
