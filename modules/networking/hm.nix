{ config, lib, helpers, ... }: {
  imports = [];

  
  options.bead.networking = {
    ssh.enable = helpers.mkBooleanOption false "Whether to allow SSH connections for this user";
  };


  config = {};
}
