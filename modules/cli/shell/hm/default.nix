{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.cli.shell;
in {
  imports = helpers.getSubmodules ../hm;


  options.bead.cli.shell = {};


  config = {};
}
