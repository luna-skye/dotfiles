{ config, lib, bead, ... }: let
  cfg = config.bead.apps;
in {
  imports = bead.autoload ../apps;


  options.bead.apps = {
    default = {
      browser = bead.mkListOfOption lib.types.str [] "User's default browser application";
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
    } // browserAssociations;
  in {
    xdg.mimeApps = {
      associations.added = xdgAssociations;
      defaultApplications = xdgAssociations;
    };
  };
}
