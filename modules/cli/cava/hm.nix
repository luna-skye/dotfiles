{ config, pkgs, lib, helpers, stellae, ... }:


let
  cfg = config.zen.cli.cava;
  element = config.zen.theme.element;

in {
  options.zen.cli.cava = {
    enable = helpers.mkBooleanOption false "Whether to install and configure the Cava CLI audio visualizer";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.cava ];
    home.file.".config/cava/config".text = ''
      [general]
      mode = normal
      framerate = 165

      autosens = 0
      ; overshoot = 20
      sensitivity = 50

      ; bars = 512
      ; bar_width = 2
      ; bar_spacing = 1
      bar_height = 16

      lower_cutoff_freq = 20
      higher_cutoff_freq = 10000
      ; sleep_timer = 0

      [output]
      method = noncurses
      ; orientation = bottom
      channels = mono
      ; mono_options average
      ; reverse = 0

      [color]
      ; background = '#${stellae.lib.hslToHex element.surface.crust}'
      foreground = '#${stellae.lib.hslToHex element.tokens.primary}'

      gradient = 0
      gradient_count = 8
      gradient_color_1 = '#a14ff3'
      gradient_color_2 = '#8c4fe6'
      gradient_color_3 = '#784ed8'
      gradient_color_4 = '#654dc9'
      gradient_color_5 = '#544ab8'
      gradient_color_6 = '#4347a7'
      gradient_color_7 = '#344494'
      gradient_color_8 = '#273f82'

      [smoothing]
      ; integral = 77
      monstercat = 0
      ; waves = 0
      gravity = 400
      ; ignore = 0
      ; noise_reduction = 77

      [eq]
      ; 1 = 1
      ; 2 = 1
      ; 3 = 1
      ; 4 = 1
      ; 5 = 1
    '';
  };
}
