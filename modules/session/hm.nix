{ config, lib, bead, ... }: {
  imports = bead.getScopedSubmodules ../session "hm";


  options.bead.session = {};


  config = {};
}
