{ config, lib, stellae, ... }:


let
  inherit (lib) mkDefault;

in {
  programs.kitty = {
    enable = mkDefault true;
    themeFile = mkDefault "Catppuccin-Mocha";

    settings = stellae.exporters.kitty.hmOptions { element = config.zen.theme.element; } // {
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
