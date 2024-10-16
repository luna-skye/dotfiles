{ config, lib, bead, pkgs, ... }: {
  imports = bead.autoload ../cli;


  options.bead.cli = {};


  config = {
    environment.systemPackages = builtins.attrValues { inherit (pkgs)
      wget
      git gitui

      just
      tmux
      btop
      eza
      sloc

      fd
      ripgrep
      p7zip
      file
      moreutils
      ;
    };
  };
}
