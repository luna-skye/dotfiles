{ config, lib, bead, ... }: let
  cfg = config.bead.session;
in {
  imports = bead.autoload ../session;


  options.bead.session = {
    default = bead.mkStringOption "" "The default graphical session to pre-select or auto-load into";
  };


  config = {
    services.displayManager.defaultSession = cfg.default;

    # TODO: understand what all of these do and if they're still needed, it's old and likely outdated, incorrect, or misplaced
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      __GL_GSYNC_ALLOWED = "0";
      XDG_SESSION_TYPE = "wayland";
    };
    hardware.graphics.enable = true;
    xdg.portal.wlr.enable = true;
  };
}
