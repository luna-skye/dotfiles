{ lib, ... }:

{
  imports = [];

  options.bead.cli.direnv = {};

  config = {
    programs.direnv = {
      enable = lib.mkDefault true;
      nix-direnv.enable = lib.mkDefault true;

      # enableBashIntegration = lib.mkDefault true;
      # enableFishIntegration = lib.mkDefault true;
      # enableNushellIntegration = lib.mkDefault true;

      config = {
        global.hide_env_diff = lib.mkDefault true;
      };
    };
  };
}
