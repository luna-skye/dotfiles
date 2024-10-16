{ config, lib, bead, ... }: {
  imports = [];


  options.bead.cli.direnv = {
    enable = bead.mkBooleanOption true "Whether to enable direnv for the Home Manager user";
  };


  config = lib.mkIf (config.bead.cli.direnv.enable) {
    programs.direnv = {
      enable = lib.mkDefault true;
      nix-direnv.enable = lib.mkDefault true;

      #  TODO: figure out why these are read only
      enableBashIntegration = lib.mkDefault true;
      # enableFishIntegration = lib.mkDefault config.bead.cli.shell.fish.enable;
      # enableNushellIntegration = lib.mkDefault config.bead.cli.shell.nushell.enable;

      config = {
        global.hide_env_diff = lib.mkDefault true;
      };
    };

    #  TODO: Make sure this configuration is actually needed, might be handled above

    # programs.fish = lib.mkIf (config.bead.cli.shell.fish.enable) {
    #   shellInit = ''
    #     direnv hook fish | source
    #   '';
    # };
    #
    # programs.nushell = lib.mkIf (config.bead.cli.shell.nushell.enable) {
    #   configFile = { text =  ''
    #     { ||
    #       if (which direnv | is-empty) {
    #         return
    #       }
    #
    #       direnv export json | from json | default {} | load-env
    #     }
    #   ''; };
    # };
  };
}
