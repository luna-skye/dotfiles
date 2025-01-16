{ config, lib, helpers, ... }: let
  cfg = config.bead.cli.shell.omp;
in {
  imports = [];


  options.bead.cli.shell.omp = {
    enable = helpers.mkBooleanOption true "Whether to enable the Oh-My-Posh shell prompt";

    enableFish = helpers.mkBooleanOption true "Whether to enable the Oh-My-Posh shell prompt for the Fish shell";
    enableNushell = helpers.mkBooleanOption true "Whether to enable the Oh-My-Posh shell prompt for Nushell";
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
