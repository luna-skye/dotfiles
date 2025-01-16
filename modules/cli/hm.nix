{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.cli;
in {
  imports = helpers.getScopedSubmodules ../cli "hm";


  options.bead.cli = {
    enableFun = helpers.mkBooleanOption true "Whether to enable various fun CLI packages";
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
