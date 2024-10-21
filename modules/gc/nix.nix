{ config, lib, bead, ... }: {
  imports = [];


  options.bead.gc = {
    enable = bead.mkBooleanOption true "Whether to enable automatic garbage collection on the NixOS system";
  };


  config = lib.mkIf (config.bead.gc.enable) {
    boot.loader.systemd-boot.configurationLimit = 10;
    nix.gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 1w";
    };
    nix.settings.auto-optimise-store = true;
  };
}
