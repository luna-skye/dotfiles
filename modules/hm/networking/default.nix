{ config, lib, bead, ... }: {
  imports = [];

  
  options.bead.networking = {
    ssh.enable = bead.mkBooleanOption false "Whether to allow SSH connections for this user";
  };


  config = {};
}
