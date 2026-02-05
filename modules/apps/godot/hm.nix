{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.godot;

  # locked to Godot version 4.5.1
  # found using https://history.nix-packages.com/search?search=godot_4
  gdpkgs = import (builtins.fetchGit {
    name = "godot-4.5.1";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "6308c3b21396534d8aaeac46179c14c439a89b8a";
  }) { inherit (pkgs.stdenv.hostPlatform) system; };

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [ gdpkgs.godot ];
  };
}
