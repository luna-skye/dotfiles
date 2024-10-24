{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.apps.terminal;
in {
  imports = [];


  options.bead.apps.terminal = {
    default = bead.mkListOfOption lib.types.str [ "kitty" ] "Which terminal emulator to set as the default";

    kitty = {
      enable = bead.mkBooleanOption false "Whether to enable the Kitty terminal emulator";

      defaultShell = bead.mkStringOption "${pkgs.fish}/bin/fish" "The default shell path to use in Kitty";
    };
  };


  config = {
    programs.kitty = lib.mkIf (cfg.kitty.enable) {
      enable = lib.mkDefault true;

      settings = {
        shell = lib.mkDefault cfg.kitty.defaultShell;
        scrollback_lines = lib.mkDefault 10000;
        enable_audio_bell = lib.mkDefault false;
        update_check_interval = lib.mkDefault 0;

        scrollback_fill_enlarged_window = lib.mkDefault "yes";
        mouse_hide_wait = lib.mkDefault 1;

        remember_window_size = lib.mkDefault "yes";
        initial_window_width = lib.mkDefault 1280;
        initial_window_height = lib.mkDefault 720;
        window_margin_width = lib.mkDefault 2;
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
