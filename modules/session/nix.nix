{ config, lib, helpers, ... }: let
  cfg = config.bead.session;
in {
  imports = helpers.getScopedSubmodules ../session "nix";


  options.bead.session = {
    default = helpers.mkNullOrOption lib.types.str null "The default graphical session to pre-select or auto-load into";
  };


  config = {
    services.displayManager.defaultSession = lib.mkDefault cfg.default;

    # TODO: understand what all of these do and if they're still needed, it's old and likely outdated, incorrect, or misplaced
    environment.variables = {
      NIXOS_OZONE_WL = lib.mkDefault "1";
      __GL_GSYNC_ALLOWED = lib.mkDefault "0";
      XDG_SESSION_TYPE = lib.mkDefault "wayland";
    };
    hardware.graphics.enable = lib.mkDefault true;
    xdg.portal.wlr.enable = lib.mkDefault true;
  };
}
