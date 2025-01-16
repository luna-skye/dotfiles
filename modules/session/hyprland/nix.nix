{ config, lib, helpers, ... }: let 
  cfg = config.bead.session.hyprland;

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


  options.bead.session.hyprland = {
    enable = helpers.mkBooleanOption false "Whether to enable the Hyprland session and related services for the NixOS system";

    monitors = helpers.mkListOfOption monitorOptionType [{
      name = "";
      resolution = "highres";
      offset = "auto";
      refreshRate = null;
      workspaces = [1];
    }] "Defines monitors, resolution, and offsets for Hyprland monitor layout";
  };


  config = lib.mkIf (cfg.enable) {
    programs.hyprland.enable = lib.mkDefault true;
  };
}
