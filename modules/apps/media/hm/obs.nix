{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.apps.media.video.obs;
in {
  imports = [];


  options.bead.apps.media.video.obs = {
    enable = bead.mkBooleanOption false "Whether to enable the OBS Studio software and configuration";

    enableDefaultPlugins = bead.mkBooleanOption true "Whether to enable the OBS Studio software and configuration";
    plugins = bead.mkListOfOption lib.types.package [] "Extra plugins to install into OBS Studio";
  };


  config = lib.mkIf (cfg.enable) {
    programs.obs-studio = {
      enable = true;

      plugins = let
        inherit (lib.lists) optionals;
        defaults = builtins.attrValues { inherit (pkgs.obs-studio-plugins) 
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ; };
      in (optionals (cfg.enableDefaultPlugins) defaults) ++ cfg.plugins;
    };
  };
}