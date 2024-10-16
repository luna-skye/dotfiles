{ config, lib, bead, pkgs, ... }: {
  imports = bead.autoload ../browser;


  options.bead.apps.browser = {
    default = lib.mkOption {
      description = "Which browsers to set as the default browser application for the user";
      type = lib.types.listOf lib.types.str;
      default = [ "firefox" ];
    };
  };


  config = {};
}
