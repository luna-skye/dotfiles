{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.godot;

  # locked to Godot version 4.2.1
  # found using https://history.nix-packages.com/search?search=godot_4
  gdpkgs = import (builtins.fetchGit {
    name = "godot-4.2.1";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "02b8c7ddb7fe956871fa65466bf8a30fa69ec078";
  }) { inherit (pkgs) system; };

in {
  imports = [];

  options.zen.apps.godot = {};

  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ gdpkgs.godot_4 ];
  };
}
