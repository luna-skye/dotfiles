{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.apps.media;
in {
  imports = [
    ./obs.nix
  ];


  options.bead.apps.media = {
    audio = {
      tenacity = bead.mkPackageOption pkgs.tenacity "Tenacity audio editor";
      spotify  = bead.mkPackageOption pkgs.spotify  "Official Spotify music streaming";
    };

    video = {
      vlc      = bead.mkPackageOption pkgs.vlc      "VLC video player";
      mpv      = bead.mkPackageOption pkgs.mpv      "MPV video player";
      kdenlive = bead.mkPackageOption pkgs.kdenlive "Kdenlive video editor";
    };

    image = {
      oculante = bead.mkPackageOption pkgs.oculante "Oculante image viewer";
      komikku = bead.mkPackageOption pkgs.komikku "Komikku comic/manga reader";
    };
  };


  config = {
    home.packages = let
       inherit (lib.lists) optional;
    in 
      optional (cfg.audio.tenacity.enable) cfg.audio.tenacity.pkg ++
      optional (cfg.audio.spotify.enable)  cfg.audio.spotify.pkg  ++

      optional (cfg.video.vlc.enable)      cfg.video.vlc.pkg      ++
      optional (cfg.video.mpv.enable)      cfg.video.mpv.pkg      ++
      optional (cfg.video.kdenlive.enable) cfg.video.kdenlive.pkg ++

      optional (cfg.image.oculante.enable) cfg.image.oculante.pkg ++
      optional (cfg.image.komikku.enable)  cfg.image.komikku.pkg  ++
      []; # its fine, the consistent rows make brain vibrate
  };
}
