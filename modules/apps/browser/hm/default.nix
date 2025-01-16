{ config, lib, helpers, pkgs, ... }: {
  imports = [
    ./chrome
    ./floorp
  ];


  options.bead.apps.browser = {};


  config =  {};
}
