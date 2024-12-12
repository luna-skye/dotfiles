{ config, lib, bead, ... }: {
  imports = bead.getScopedSubmodules ../services "hm";


  options.bead.services = {};


  config = {};
}
