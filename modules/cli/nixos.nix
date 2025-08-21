{ config, helpers, pkgs, ... }:

let
  cfg = config.zen.cli;

in {
  imports = helpers.getScopedSubmodules ../cli "nixos";

  options.zen.cli = {};

  config = {
    environment.systemPackages = builtins.attrValues { inherit (pkgs)
      nh
      home-manager
      wget
      git

      just
      tmux
      btop
      eza

      fd
      ripgrep
      p7zip
      file
      moreutils
      gvfs
      sops
      age
      ;
    };
  };
}
