{ config, lib, helpers, ... }: {
  imports = bead.getScopedSubmodules ../session "hm";


  options.bead.session = {};


  config = {};
}
