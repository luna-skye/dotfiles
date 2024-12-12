{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.cli.shell;
in {
  imports = bead.getSubmodules ../hm;


  options.bead.cli.shell = {};


  config = {};
}
