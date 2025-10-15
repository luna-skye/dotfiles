{ config, lib, helpers, pkgs, ... }:


let
  cfg = config.zen.apps.obsidian;

in {
  imports = [];

  options.zen.apps.obsidian = {
    enable = helpers.mkBooleanOption false "Whether to install the Obsidian note taking app";
  };

  config = lib.mkIf (cfg.enable) {
    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0" # required by obsidian, but is EOL
    ];

    environment.systemPackages = [
      pkgs.obsidian
    ];
  };
}
