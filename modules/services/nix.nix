{ config, lib, helpers, ... }: {
  imports = helpers.getScopedSubmodules ../services "nix";


  options.bead.services = {};


  config = {};
}
