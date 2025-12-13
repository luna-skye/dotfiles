{ config, lib, helpers, pkgs, ... }:

let
  cfg = config.zen.cli;

in {
  imports = helpers.getScopedSubmodules ../cli "hm";

  options.zen.cli = {
    enableFun = helpers.mkBooleanOption true "Whether to enable fun CLI packages";
  };

  config = {
    home.packages = builtins.attrValues { inherit (pkgs)
      gitui
      tealdeer
      glow
      gping
      onefetch
      sloc
      nmap
      gource
      bat
      yt-dlp
      jq
      ydotool
      ;
    } ++ lib.lists.optionals (cfg.enableFun) builtins.attrValues { inherit (pkgs) 
      fortune-kind
      gay
      kittysay
      lolcat
      asciiquarium
      lavat
      sl
      ;
    };
  };
}
