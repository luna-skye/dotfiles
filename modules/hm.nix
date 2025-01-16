{ config, lib, helpers, ... }: {
  imports = helpers.getScopedSubmodules ../modules "hm";


  options.bead = {
    extraPkgs = helpers.mkListOfOption lib.types.package [] "Extra packages to install into the user's profile";
  };


  config = {
    home.packages = config.bead.extraPkgs;

    home.file.".config/totality-nixos/logo.jpg".source = ../assets/logo.jpg;

    #  WARN: DO NOT CHANGE THESE
    home.stateVersion = lib.mkForce "23.11";
    programs.home-manager.enable = lib.mkForce true;
  };
}
