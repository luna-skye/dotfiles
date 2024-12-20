{ config, lib, bead, ... }:

let
  cfg = config.bead.gc;
in {
  imports = [];


  options.bead.gc = {
    enableAuto = bead.mkBooleanOption true "Whether to enable automatic garbage collection on the NixOS system";
  };


    boot.loader.systemd-boot.configurationLimit = 10;
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 1w";
  config = {
    nix.gc = lib.mkIf (cfg.enableAuto) {
    };
    nix.settings.auto-optimise-store = true;
  };
}
