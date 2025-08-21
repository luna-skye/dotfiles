{ lib, helpers, ... }: {
  imports = helpers.getScopedSubmodules ../modules "hm";
  options.zen = {};
  config = {
    home.file.".config/totality-nixos/logo.png".source = ../.assets/logo.png;

    #  WARN: DO NOT CHANGE THESE
    home.stateVersion = lib.mkForce "23.11";
    programs.home-manager.enable = lib.mkForce true;
  };
}
