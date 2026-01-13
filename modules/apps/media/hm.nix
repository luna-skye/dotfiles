{ osConfig, pkgs, lib, ... }:

let
  inherit (lib) optional;
  hostCfg = osConfig.zen.apps.media;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = 
      optional (hostCfg.image.gwenview.enable) pkgs.kdePackages.gwenview ++

      # temporarily disabled due to build failures on 2026-01-13
      # see issue: https://github.com/NixOS/nixpkgs/issues/475989
      # and pr fix: https://github.com/NixOS/nixpkgs/pull/476565 (merged 2026-01-12)
      # optional (hostCfg.image.oculante.enable) pkgs.oculante             ++

      optional (hostCfg.video.vlc.enable)      pkgs.vlc                  ++
      optional (hostCfg.video.mpv.enable)      pkgs.mpv                  ++
      optional (hostCfg.audio.elisa.enable)    pkgs.kdePackages.elisa    ++
      [];
  };
}
