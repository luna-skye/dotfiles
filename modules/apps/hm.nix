{ config, lib, bead, ... }: let
  cfg = config.bead.apps;
in {
  imports = bead.getScopedSubmodules ../apps "hm";


  options.bead.apps = {
    default = {
      browser = bead.mkListOfOption lib.types.str [] "User's default browser application";
      audio = bead.mkListOfOption lib.types.str [] "User's default audio application";
      video = bead.mkListOfOption lib.types.str [] "User's default video application";
      image = bead.mkListOfOption lib.types.str [] "User's default image application";
    };
  };


  config = let
    browserAssociations = builtins.listToAttrs(map (s: { name = s; value = cfg.default.browser; }) [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/ftp"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
      "application/x-extension-htm"
      "application/x-extension-html"
      "application/x-extension-shtml"
      "application/xhtml+xml"
      "application/x-extension-xhtml"
      "application/x-extension-xht"
      "application/json"
      "application/pdf"
    ]);

    xdgAssociations = {
      "audio/*" = cfg.default.audio;
      "video/*" = cfg.default.video;
      "image/*" = cfg.default.image;
    } // browserAssociations;
  in {
    xdg.mimeApps = {
      associations.added = xdgAssociations;
      defaultApplications = xdgAssociations;
    };
  };
}
