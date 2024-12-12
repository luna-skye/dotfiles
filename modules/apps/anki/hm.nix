{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.apps.anki;
in {
  imports = [];


  options.bead.apps.anki = {
    enable = bead.mkBooleanOption false "Whether to install the Anki spaced repetition flashcard application";
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.anki-bin ];
  };
}
