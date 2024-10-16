{ config, lib, bead, ... }: let
  cfg = config.bead.cli.zoxide;
in {
  imports = [];


  options.bead.cli.zoxide = {
    enable = bead.mkBooleanOption true "Whether to enable Zoxide on the system";

    #  TODO: Figure this one out, for all shells, selective shells? Then implement it
    #  Idea, in each shell there'd be a `aliasCdToZ` boolean option, then it's handled per shell
    replaceCd = bead.mkBooleanOption true "Whether to register Zoxide as a replacement for the cd command";
  };


  config = lib.mkIf (cfg.enable) {
    programs.zoxide = {
      enable = lib.mkDefault true;
      
      enableFishIntegration    = lib.mkDefault config.bead.cli.shell.fish.enable;
      enableNushellIntegration = lib.mkDefault config.bead.cli.shell.nushell.enable;
    };
  };
}
