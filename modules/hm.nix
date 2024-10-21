{ config, lib, bead, ... }: {
  imports = bead.getScopedSubmodules ../modules "hm";


  options.bead = {
    extraPkgs = bead.mkListOfOption lib.types.package [] "Extra packages to install into the user's profile";
  };


  config = {
    home.packages = config.bead.extraPkgs;

    #  WARN: DO NOT CHANGE THESE
    home.stateVersion = lib.mkForce "23.11";
    programs.home-manager.enable = lib.mkForce true;
  };
}
