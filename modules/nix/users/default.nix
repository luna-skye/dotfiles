{ config, lib, ... }: {
  imports = [];


  options.bead.user = {};


  config = {
    # automatically registers configured hm users into NixOS
    users.users = builtins.mapAttrs (name: cfg: {
      description  = lib.mkDefault cfg.bead.user.name;
      isNormalUser = lib.mkDefault cfg.bead.user.isNormalUser;
      extraGroups  = lib.mkDefault cfg.bead.user.extraGroups;
    }) config.home-manager.users;
  };
}
