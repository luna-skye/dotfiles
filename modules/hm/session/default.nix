{ config, lib, bead, ... }: {
  imports = bead.autoload ../session;


  options.bead.session = {};


  config = {};
}
