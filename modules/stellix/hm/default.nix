{ config, lib, bead, ... }: let 
  cfg = config.bead.stellix;
in {
  imports = [
    ./fonts.nix
  ] ++ bead.getSubmodules ./targets;


  options.bead.stellix = {
    enable = bead.mkBooleanOption false "Whether to enable the STELLIX styling module";

    palette = lib.mkOption {
      description = "STELLAE compliant color palette to use within STELLIX";
      type = lib.types.attrs;
      default = lib.importJSON ./palettes/stellae.json;
    };

    autoTarget = bead.mkBooleanOption false "Whether to enable automatically detecting targets to apply STELLIX to, from bead/hm config";
  };


  # auto-targeting
  config = lib.mkIf (cfg.enable && cfg.autoTarget) {
    bead.stellix.targets = {
      btop.enable     = lib.mkDefault true;
      dunst.enable    = lib.mkDefault config.services.dunst.enable;
      hyprland.enable = lib.mkDefault config.wayland.windowManager.hyprland.enable;
      kitty.enable    = lib.mkDefault config.programs.kitty.enable;
      tmux.enable     = lib.mkDefault config.programs.tmux.enable;
      yazi.enable     = lib.mkDefault config.programs.yazi.enable;
    };
  };
}
