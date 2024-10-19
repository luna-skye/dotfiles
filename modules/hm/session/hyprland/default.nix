{ config, osConfig, lib, bead, pkgs, ... }: let
  cfg = config.bead.session.hyprland;
  osCfg = osConfig.bead.session.hyprland;

  # Generates a list of strings representing Hyprland workspace monitor relations
  # Values are pulled from OS config options
  genWorkspaces = lib.foldl' (acc: monitor:
    lib.foldl' (acc2: ws:
      acc2 ++ [ "${builtins.toString ws}, monitor:${monitor.name}" ]
    ) acc monitor.workspaces
  ) [] osCfg.monitors;

  # Generates a list of strings representing Hyprland monitor configuration, including name, resolution, refresh rate, etc.
  # Values are pulled from OS config options
  genMonitors = lib.map (m:
    let
      rr = if (builtins.isNull m.refreshRate) then "" else "@${builtins.toString m.refreshRate}";
    in
      "${m.name}, ${m.resolution}${rr}, ${m.offset}, 1"
  ) osCfg.monitors;
in {
  imports = [
    ./keybinds.nix
  ];


  options.bead.session.hyprland = {
    enable = bead.mkBooleanOption false "Whether to enable the Hyprland Window Manager and associated configuration";

    execOnce = bead.mkListOfOption lib.types.str [] "Commands to execute at Hyprland startup";

    defaultWindowRules = bead.mkBooleanOption true "Whether to apply default Hyprland window rules";
    windowRules = bead.mkListOfOption lib.types.str [] "Rules to apply to windows";

    defaultLayerRules = bead.mkBooleanOption true "Whether to apply default Hyprland layer rules";
    layerRules = bead.mkListOfOption lib.types.str [] "Rules to apply to layers";
  };


  config = lib.mkIf (osCfg.enable) {
    wayland.windowManager.hyprland = {
      enable          = lib.mkDefault true;
      xwayland.enable = lib.mkDefault true;
      systemd.enable  = lib.mkDefault true;

      settings = {
        workspace = lib.mkDefault genWorkspaces;
        monitor   = lib.mkDefault genMonitors;

        exec-once = [
          "swww init"                                    # start wallpaper daemon
          "dunst"                                        # start notif daemon
          "wl-paste --type text --watch cliphist store"  # setup wl-paste to watch cliphist
          "wl-paste --type image --watch cliphist store" # same as above but for images
          "nm-applet --indicator"                        # start networking manager applet
        ] ++ cfg.execOnce;

        windowrulev2 = (if cfg.defaultWindowRules then [
          # picture in picture windows
          "float, title:^(Picture-in-Picture)$"
          "pin, title:^(Picture-in-Picture)$"
          "keepaspectratio, title:^(Picture-in-Picture)$"
          "opaque, title:^(Picture-in-Picture)$"

          # always opaque apps
          "opaque, class:^(blender)$"
          "opaque, initialTitle:^(Godot)"
        ] else []) ++ cfg.windowRules;

        layerrule = (if cfg.defaultLayerRules then [
          "blur, ^(gtk-layer-shell)$"
          "blur, ^(launcher)$"
          "blur, notifications"

          "noanim, launcher"
          "noanim, bar"
        ] else []) ++ cfg.layerRules;
      };
    };

    home.packages = builtins.attrValues { inherit (pkgs)
      swww                 # wallpaper service
      tofi                 # app launcher

      networkmanagerapplet # network manager
      dunst                # notif service
      libnotify

      hyprpicker           # color picker
      grim                 # screenshot utility
      slurp                # screen region selection

      wl-clipboard         # clipboard
      playerctl            # media control utility
      pamixer              # audio device manager

      sassc # used for AGS
      ;
    };

    services.cliphist.enable = lib.mkDefault true;

    #  TODO: fix this, don't wildcard the portals
    xdg.portal = {
      enable = lib.mkDefault true;
      config.common.default = "*";
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };
  };
}
