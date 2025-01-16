{ config, lib, helpers, ... }: let
  cfg = config.bead.stellix.targets.btop;
  colors = config.bead.stellix.palette;
in {
  imports = [];


  options.bead.stellix.targets.btop = {
    enable = helpers.mkBooleanOption false "Whether to enable Btop as a theme target for STELLIX";

    background = helpers.mkBooleanOption false "Whether to enable the theme's background for Btop";
    roundedCorners = helpers.mkBooleanOption false "Whether to enable the rounded corners in Btop";
  };

  
  config = lib.mkIf (config.bead.stellix.enable && cfg.enable) {
    programs.btop = {
      settings = {
        #  TODO: use the generated stellix theme by default
        theme_background = lib.mkDefault cfg.background;
        rounded_corners  = lib.mkDefault cfg.roundedCorners;
        truecolor        = lib.mkDefault true;
      };
    };

    home.file.".config/btop/themes/stellix.theme".text = import ./theme.nix { inherit lib; inherit colors; };
  };
}
