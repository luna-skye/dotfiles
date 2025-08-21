{ config, lib, helpers, ... }:

let
  cfg = config.zen.cli.shell.omp;

in {
  imports = [];

  options.zen.cli.shell.omp = {
    enableFish = helpers.mkBooleanOption true "Whether to enable the Oh-My-Posh shell prompt for the Fish shell";
    enableNushell = helpers.mkBooleanOption true "Whether to enable the Oh-My-Posh shell prompt for Nushell";
  };

  config = {
    programs.oh-my-posh = {
      enable = lib.mkDefault true;
      enableFishIntegration = lib.mkDefault cfg.enableFish;
      enableNushellIntegration = lib.mkDefault cfg.enableNushell;
      settings = builtins.fromJSON (
                 builtins.unsafeDiscardStringContext (
                 builtins.readFile ./omp-theme.json));
    };
  };
}
