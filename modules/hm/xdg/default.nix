{ config, lib, bead, ... }: let
  associations = config: {
    "text/html" = config.bead.xdg.app.browser;
    "x-scheme-handler/http" = config.bead.xdg.app.browser;
    "x-scheme-handler/https" = config.bead.xdg.app.browser;
    "x-scheme-handler/ftp" = config.bead.xdg.app.browser;
    "x-scheme-handler/about" = config.bead.xdg.app.browser;
    "x-scheme-handler/unknown" = config.bead.xdg.app.browser;
    "application/x-extension-htm" = config.bead.xdg.app.browser;
    "application/x-extension-html" = config.bead.xdg.app.browser;
    "application/x-extension-shtml" = config.bead.xdg.app.browser;
    "application/xhtml+xml" = config.bead.xdg.app.browser;
    "application/x-extension-xhtml" = config.bead.xdg.app.browser;
    "application/x-extension-xht" = config.bead.xdg.app.browser;
    "application/json" = config.bead.xdg.app.browser;
    "application/pdf" = config.bead.xdg.app.browser;

    "audio/*" = config.bead.xdg.app.audio;
    "video/*" = config.bead.xdg.app.video;
    "image/*" = config.bead.xdg.app.image;
  };
in {
  imports = [];

  #  TODO: Seeing as a lot of responsibilities for this file have moved elsewhere, look into repurposing this for other XDG options


  options.bead.xdg = {
    enable = bead.mkBooleanOption true "Enable automatic configuration of user XDG, including home directories and default applications";

    #  TODO: Move default applications into separate config module called "apps"
    app = lib.mkOption {};
  };


  config = lib.mkIf (config.bead.xdg.enable) {
    xdg = {

      # setup default applications through mimeApps
      # mimeApps = {
      #   enable = true;
      #   associations.added = associations config;
      #   defaultApplications = associations config;
      # };
    };
  };
}
