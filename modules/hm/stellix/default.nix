{ config, lib, bead, ... }: let 
  cfg = config.bead.stellix;
in {
  imports = bead.autoload ./targets;


  options.bead.stellix = {
    enable = bead.mkBooleanOption "Whether to enable the STELLIX styling module" false;

    palette = lib.mkOption {
      description = "STELLAE compliant color palette to use within STELLIX";
      type = lib.types.attrs;
      default = lib.importJSON ./palettes/stellae.json;
    };
  };


  config = lib.mkIf (cfg.enable) {};
}
