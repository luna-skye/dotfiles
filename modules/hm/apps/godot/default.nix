{ config, lib, bead, pkgs, ... }:
let
  gdpkgs = import (builtins.fetchGit {
    name = "godot-4.2.1";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "02b8c7ddb7fe956871fa65466bf8a30fa69ec078";
  }) { inherit (pkgs) system; };
in {
  imports = [];


  options.bead.apps.godot = {
    enable = bead.mkBooleanOption false "Whether to enable the Godot Game Engine application for the user";
  };


  config = lib.mkIf (config.bead.apps.godot.enable) {
    home.packages = [ gdpkgs.godot_4 ];
  };
}
