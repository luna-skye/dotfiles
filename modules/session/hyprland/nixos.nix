{ config, lib, helpers, ... }:

let 
  cfg = config.zen.session.hyprland;

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
  imports = [];

  options.zen.session.hyprland = {
    enable = helpers.mkBooleanOption false "Whether to install the Hyprland window manager";

    monitors = helpers.mkListOfOption monitorOptionType [{
      name = "";
      resolution = "highres";
      offset = "auto";
      refreshRate = null;
      workspaces = [1];
    }] "Defines monitors, resolution, and offsets for Hyprland monitor layout";

    defaultExecOnce = helpers.mkBooleanOption true "Whether to apply default execOnce commands";
    execOnce = helpers.mkListOfOption lib.types.str [] "Commands to execute at Hyprland startup";

    defaultWindowRules = helpers.mkBooleanOption true "Whether to apply default Hyprland window rules";
    windowRules = helpers.mkListOfOption lib.types.str [] "Rules to apply to windows";

    defaultLayerRules = helpers.mkBooleanOption true "Whether to apply default Hyprland layer rules";
    layerRules = helpers.mkListOfOption lib.types.str [] "Rules to apply to layers";
  };

  config = lib.mkIf (cfg.enable) {
    programs.hyprland.enable = lib.mkDefault true;
  };
}
