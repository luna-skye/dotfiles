{ config, lib, bead, ... }: let 
  monitorOptionType = lib.types.submodule {
    options = {
      name        = bead.mkStringOption ""        "The internal ID of the monitor";
      resolution  = bead.mkStringOption "highres" "The target resolution for the monitor";
      offset      = bead.mkStringOption "auto"    "Offset for the monitor, similar to resolution";
      refreshRate = bead.mkNullOrOption lib.types.number null "Target refresh rate for the monitor";
      workspaces  = bead.mkListOfOption lib.types.number [1]  "List of workspace indices allocated to this monitor";
    };
  };
in {
  imports = [];


  options.bead.session.hyprland = {
    monitors = bead.mkListOfOption monitorOptionType [{
      name = "";
      resolution = "highres";
      offset = "auto";
      refreshRate = null;
      workspaces = [1];
    }] "Defines monitors, resolution, and offsets for Hyprland monitor layout";
  };


  config = lib.mkIf (bead.anyUserHasEnabled ["bead" "session" "hyprland" "enable"] config) {
    programs.hyprland.enable = lib.mkDefault true;
    services.displayManager.defaultSession = lib.mkDefault "hyprland";
  };
}
