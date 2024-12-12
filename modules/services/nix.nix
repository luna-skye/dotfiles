{ config, lib, bead, ... }: {
  imports = bead.getScopedSubmodules ../services "nix";


  options.bead.services = {};


  config = {};
}
