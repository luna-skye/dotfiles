{ osConfig, pkgs, lib, ... }:

let
  inherit (lib) optional;
  hostCfg = osConfig.zen.apps.media;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = 
      optional (hostCfg.image.gwenview.enable) pkgs.kdePackages.gwenview ++
      optional (hostCfg.image.oculante.enable) pkgs.oculante             ++
      optional (hostCfg.video.vlc.enable)      pkgs.vlc                  ++
      optional (hostCfg.video.mpv.enable)      pkgs.mpv                  ++
      optional (hostCfg.audio.elisa.enable)    pkgs.kdePackages.elisa    ++
      [];
  };
}
