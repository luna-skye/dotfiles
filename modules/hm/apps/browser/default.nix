{ config, lib, bead, pkgs, ... }: {
  imports = bead.autoload ../browser;


  options.bead.apps.browser = {};


  config =  {};
}
