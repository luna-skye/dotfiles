{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.apps.anki;
in {
  imports = [];


  options.bead.apps.anki = {
    enable = helpers.mkBooleanOption false "Whether to install the Anki spaced repetition flashcard application";
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.anki-bin ];
  };
}
