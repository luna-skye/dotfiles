{ helpers, pkgs, lib, ... }:

let
  inherit (lib) mkDefault;

in {
  imports = [];
  options.zen.apps.kitty = {};
  config = {
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
      };

      extraConfig = ''
      modify_font underline_position 4
      modify_font underline_thickness 150%
      modify_font strikethrough_position 3px
      modify_font cell_height +4px

      disable_ligatures cursor
      '';
    };
  };
}
