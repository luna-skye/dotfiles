{ config, lib, bead, ... }: let
  cfg = config.bead.cli.shell.omp;
in {
  imports = [];


  options.bead.cli.shell.omp = {
    enable = bead.mkBooleanOption true "Whether to enable the Oh-My-Posh shell prompt";

    enableFish = bead.mkBooleanOption true "Whether to enable the Oh-My-Posh shell prompt for the Fish shell";
    enableNushell = bead.mkBooleanOption true "Whether to enable the Oh-My-Posh shell prompt for Nushell";
  };


  config = lib.mkIf (cfg.enable) {
    programs.oh-my-posh = let
      inherit (builtins) fromJSON unsafeDiscardStringContext readFile;
    in {
      enable = lib.mkDefault true;

      enableFishIntegration = lib.mkDefault cfg.enableFish;
      enableNushellIntegration = lib.mkDefault cfg.enableNushell;

      settings = fromJSON (
                 unsafeDiscardStringContext (
                 readFile ./omp-theme.json));
    };
  };
}
