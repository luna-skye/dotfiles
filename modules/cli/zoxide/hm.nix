{ lib, ... }:

{
  imports = [];

  options.zen.cli.zoxide = {};

  config = {
    programs.zoxide = {
      enable = lib.mkDefault true;
      enableFishIntegration = lib.mkDefault true;
      enableNushellIntegration = lib.mkDefault true;
    };
  };
}
