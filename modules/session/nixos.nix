{ config, lib, helpers, ... }:

let
  cfg = config.zen.session;

in {
  imports = helpers.getScopedSubmodules ../session "nixos";

  options.zen.session = {
    default = helpers.mkNullOrOption lib.types.str null "The default graphical session to pre-select or auto-load into";
  };

  config = {
    services.displayManager.defaultSession = lib.mkForce cfg.default;

    environment.variables = {
      NIXOS_OZONE_WL = lib.mkDefault "1";
      __GL_GSYNC_ALLOWED = lib.mkDefault "0";
      XDG_SESSION_TYPE = lib.mkDefault "wayland";
    };
    hardware.graphics.enable = lib.mkDefault true;
  };
}
