{ config, lib, bead, pkgs, ... }: {
  imports = [
    ./chrome
    ./floorp
  ];


  options.bead.apps.browser = {};


  config =  {};
}
