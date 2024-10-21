{ config, lib, bead, pkgs, ... }: {
  imports = [
    ./chrome.nix
    ./floorp.nix
  ];


  options.bead.apps.browser = {};


  config =  {};
}
