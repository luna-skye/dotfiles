{ config, lib, helpers, ... }:


let 
  cfg = config.zen.session.hyprland;

in {
  imports = [];

  options.zen.session.hyprland = {
    enable = helpers.mkBooleanOption false "Whether to install the Hyprland window manager";

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
