{ config, lib, helpers, ... }:


let
  cfg = config.zen.session;
  monitorOptionType = lib.types.submodule {
    options = {
      name        = helpers.mkStringOption ""        "The internal ID of the monitor";
      resolution  = helpers.mkStringOption "highres" "The target resolution for the monitor";
      offset      = helpers.mkStringOption "auto"    "Offset for the monitor, similar to resolution";
      refreshRate = helpers.mkNullOrOption lib.types.number null "Target refresh rate for the monitor";
      workspaces  = helpers.mkListOfOption lib.types.number [1]  "List of workspace indices allocated to this monitor";
    };
  };

in {
  imports = helpers.getScopedSubmodules ../session "nixos";

  options.zen.session = {
    default = helpers.mkNullOrOption lib.types.str null "The default graphical session to pre-select or auto-load into";
    monitors = helpers.mkListOfOption monitorOptionType [{
      name = "";
      resolution = "highres";
      offset = "auto";
      refreshRate = null;
      workspaces = [1];
    }] "Defines monitors, resolution, and offsets for window manager monitor layout";
  };

  config = {
    hardware.graphics.enable = lib.mkDefault true;
    services.displayManager.defaultSession = lib.mkForce cfg.default;

    environment.variables = {
      NIXOS_OZONE_WL = lib.mkDefault "1";
      __GL_GSYNC_ALLOWED = lib.mkDefault "0";
      XDG_SESSION_TYPE = lib.mkDefault "wayland";
    };
  };
}
