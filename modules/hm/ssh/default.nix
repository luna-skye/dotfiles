{ config, lib, bead, ... }: {
  imports = [];

  
  options.bead.ssh = {
    enable = bead.mkBooleanOption false "Whether to allow SSH connections for this user";
  };


  config = {};
}
