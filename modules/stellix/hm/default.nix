{ config, lib, bead, ... }: let 
  cfg = config.bead.stellix;
in {
  imports = bead.getSubmodules ./targets ++ [
    ./fonts.nix
  ];


  options.bead.stellix = {
    enable = bead.mkBooleanOption false "Whether to enable the STELLIX styling module";

    palette = lib.mkOption {
      description = "STELLAE compliant color palette to use within STELLIX";
      type = lib.types.attrs;
      default = lib.importJSON ./palettes/stellae.json;
    };

    autoTarget = bead.mkBooleanOption false "Whether to enable automatically detecting targets to apply STELLIX to, from bead/hm config";
  };


  config = lib.mkIf (cfg.enable) {};
}
