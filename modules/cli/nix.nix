{ config, lib, helpers, pkgs, ... }: {
  imports = helpers.getScopedSubmodules ../cli "nix";


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
      glow
      tealdeer
      yt-dlp
      ffmpeg_4-full

      fd
      ripgrep
      p7zip
      file
      moreutils
      ;
    };
  };
}
