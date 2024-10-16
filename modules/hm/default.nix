{ lib, bead, ... }: {
  imports = bead.autoload ../hm;


  options.bead = {};


  config = {
    #  WARN: DO NOT CHANGE THESE
    home.stateVersion = lib.mkForce "23.11";
    programs.home-manager.enable = lib.mkForce true;
  };
}
