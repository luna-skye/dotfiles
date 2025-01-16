{ config, lib, helpers, ... }: let
  cfg = config.bead.cli.zoxide;
in {
  imports = [];


  options.bead.cli.zoxide = {
    enable = helpers.mkBooleanOption true "Whether to enable Zoxide on the system";
  };


  config = lib.mkIf (cfg.enable) {
    programs.zoxide = {
      enable = lib.mkDefault true;
      
      enableFishIntegration    = lib.mkDefault config.bead.cli.shell.fish.enable;
      enableNushellIntegration = lib.mkDefault config.bead.cli.shell.nushell.enable;
    };
  };
}
