{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.obs;

in {
  imports = [];
  options.zen.apps.obs = {};
  config = lib.mkIf (hostCfg.enable) {
    programs.obs-studio = {
      enable = true;
      plugins = builtins.attrValues { inherit (pkgs.obs-studio-plugins)
        wlrobs
        obs-backgroundremoval
        waveform
        input-overlay
        obs-composite-blur
        ;
      };
    };
  };
}
