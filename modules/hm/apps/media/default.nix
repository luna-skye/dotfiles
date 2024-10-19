{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.apps.media;

  mkPackageOption = pkg: name: {
    enable = bead.mkBooleanOption false "Whether to install the ${name}";
    pkg = lib.mkOption {
      description = "The package to be used in installing the ${name}";
      type = lib.types.package;
      default = pkg;
    };
  };
in {
  imports = [];


  options.bead.apps.media = {
    audio = {
      tenacity = mkPackageOption pkgs.tenacity "Tenacity audio editor";
    };

    video = {
      vlc = mkPackageOption pkgs.vlc "VLC video player";
      mpv = mkPackageOption pkgs.mpv "MPV video player";
    };

    image = {
      oculante = mkPackageOption pkgs.oculante "Oculante image viewer";
    };
  };


  config = {
    home.packages =
      lib.lists.optional (cfg.audio.tenacity.enable) cfg.audio.tenacity.pkg ++
      lib.lists.optional (cfg.video.vlc.enable)      cfg.video.vlc.pkg      ++
      lib.lists.optional (cfg.video.mpv.enable)      cfg.video.mpv.pkg      ++
      lib.lists.optional (cfg.image.oculante.enable) cfg.image.oculante.pkg
      ;
  };
}
