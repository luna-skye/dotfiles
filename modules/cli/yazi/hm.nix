{ config, lib, helpers, ... }:

let
  cfg = config.zen.cli.yazi;

in {
  imports = [];

  options.zen.cli.yazi = {
    enable = helpers.mkBooleanOption true "Whether to install and configure Yazi for the user";
    enableYyCommand = helpers.mkBooleanOption true "Whether to enable the `yy` shortcut for persistent yazi navigation";
  };

  config = lib.mkIf (cfg.enable) {
    programs.yazi = {
      enable = lib.mkDefault true;

      # enableFishIntegration    = lib.mkDefault config.zen.cli.shell.fish.enable;
      # enableNushellIntegration = lib.mkDefault config.zen.cli.shell.nushell.enable;

      #  TODO: setup some zen config options for these
      settings = {
        log.enabled = lib.mkDefault false;
        manager = {
          show_hidden    = lib.mkDefault false;
          sort_by        = lib.mkDefault "natural";
          sort_dir_first = lib.mkDefault true;
          ratio          = lib.mkDefault [2 4 2];
          show_symlink   = lib.mkDefault true;
        };
        preview = {
          tab_size = lib.mkDefault 2;
        };
      };
    };

    #  TODO: Implement fish and nushell integration for yy persistent command
  };
}
