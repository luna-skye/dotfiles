{ config, lib, helpers, ... }: {
  imports = helpers.getScopedSubmodules ../services "hm";


  options.bead.services = {};


  config = {};
}
