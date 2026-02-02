{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.godot;

  # locked to Godot version 4.5.1
  # found using https://history.nix-packages.com/search?search=godot_4
  gdpkgs = import (builtins.fetchGit {
    name = "godot-4.5.1";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "5f02c91314c8ba4afe83b256b023756412218535";
  }) { inherit (pkgs.stdenv.hostPlatform) system; };

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ gdpkgs.godot ];
  };
}
