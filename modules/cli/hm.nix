{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.cli;
in {
  imports = bead.getScopedSubmodules ../cli "hm";


  options.bead.cli = {
    enableFun = bead.mkBooleanOption true "Whether to enable various fun CLI packages";
  };


  config = let
    inherit (lib.lists) optionals;
  in {
    home.packages = optionals (cfg.enableFun) builtins.attrValues { inherit (pkgs) 
      fortune
      kittysay
      lolcat
      asciiquarium
      lavat
      ;
    };
  };
}
