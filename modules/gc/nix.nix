{ config, lib, bead, ... }:

let
  cfg = config.bead.gc;
in {
  imports = [];


  options.bead.gc = {
    enableAuto = bead.mkBooleanOption true "Whether to enable automatic garbage collection on the NixOS system";
    autoFrequency = bead.mkStringOption "weekly" "How frequently to run automatic garbage collection";
    autoDeleteAfter = bead.mkStringOption "1w" "Timeframe to keep generations around for";
  };


  config = {
    nix.settings.auto-optimise-store = lib.mkDefault cfg.enableAuto;
    nix.gc = lib.mkIf (cfg.enableAuto) {
      automatic = lib.mkDefault true;
      dates     = lib.mkDefault cfg.autoFrequency;
      options   = lib.mkDefault "--delete-older-than ${cfg.autoDeleteAfter}";
    };
  };
}
