{ config, lib, ... }:

let
  cfg = config.theme;

in {
  imports = [
    ./targets
    ./fonts.nix
  ];

  # define options for theme configuration module
  options.theme = {
    enable = lib.mkEnableOption "Enable custom color palettes";
    palette = lib.mkOption {
      type = lib.types.attrs;
      default = import ./palettes/stellae.nix;
      description = lib.mdDoc ''
        STELLAE compliant color palette for use across the system
      '';
    };
  };

  # actually do config stuff if theming is enabled
  config = lib.mkIf cfg.enable {
    # dump palette file
    # home.file."stellae_export.txt".text = ''
    # crust:    #${cfg.palette.crust}
    # mantle:   #${cfg.palette.mantle}
    # base:     #${cfg.palette.base}
    # surface0: #${cfg.palette.surface0}
    # surface1: #${cfg.palette.surface1}
    # overlay0: #${cfg.palette.overlay0}
    # overlay1: #${cfg.palette.overlay1}
    # subtext0: #${cfg.palette.subtext0}
    # subtext1: #${cfg.palette.subtext1}
    # text:     #${cfg.palette.text}
    #
    # red:           #${cfg.palette.red}
    # light_red:     #${cfg.palette.light_red}
    # orange:        #${cfg.palette.orange}
    # light_orange:  #${cfg.palette.light_orange}
    # yellow:        #${cfg.palette.yellow}
    # light_yellow:  #${cfg.palette.light_yellow}
    # green:         #${cfg.palette.green}
    # light_green:   #${cfg.palette.light_green}
    # blue:          #${cfg.palette.blue}
    # light_blue:    #${cfg.palette.light_blue}
    # cyan:          #${cfg.palette.cyan}
    # light_cyan:    #${cfg.palette.light_cyan}
    # magenta:       #${cfg.palette.magenta}
    # light_magenta: #${cfg.palette.light_magenta}
    # '';
  };
}
