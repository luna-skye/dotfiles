{ inputs, config, osConfig, lib, pkgs, ... }:

let
  inherit (lib) mkDefault;
  cfg = config.zen.session.hyprland;
  hostCfg = osConfig.zen.session.hyprland;

  # Generates a list of strings representing Hyprland workspace monitor relations
  # Values are pulled from OS config options
  genWorkspaces = lib.foldl' (acc: monitor:
    lib.foldl' (acc2: ws:
      acc2 ++ [ "${builtins.toString ws}, monitor:${monitor.name}" ]
    ) acc monitor.workspaces
  ) [] hostCfg.monitors;

  # Generates a list of strings representing Hyprland monitor configurations, including name, resolution, refresh rate, etc.
  # Values are pulled from OS config options
  genMonitors = lib.map (m:
    let rr = if (builtins.isNull m.refreshRate) then "" else "@${builtins.toString m.refreshRate}";
    in "${m.name}, ${m.resolution}${rr}, ${m.offset}, 1"
  ) hostCfg.monitors;

in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./keybinds.nix
    ./style.nix
  ];
  options.zen.session.hyprland = {};
  config = lib.mkIf (hostCfg.enable) {
    wayland.windowManager.hyprland = {
      enable          = mkDefault true;
      xwayland.enable = mkDefault true;
      systemd.enable  = mkDefault true;
      # package         = inputs.hyprland.packages.${pkgs.system}.hyprland;
      # portalPackage   = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      package         = null;
      portalPackage   = null;

      settings = {
        workspace = mkDefault genWorkspaces;
        monitor   = mkDefault genMonitors;

        exec-once = let
          inherit (lib) optional optionals;
          defaults = [
            "wl-paste --type text --watch cliphist store"  # setup wl-paste to watch cliphist
            "wl-paste --type image --watch cliphist store" # same as above but for images
            "nm-applet --indicator"                        # start networking manager applet
            "xsetroot -cursor_name left_ptr"               # fixes missing xwayland cursor
          ] ++ optional (osConfig.zen.services.dunst.enable) "dunst"
            ++ optional (osConfig.zen.services.swww.enable) "swww-daemon"
          ;
        in optionals (hostCfg.defaultExecOnce) defaults ++ hostCfg.execOnce;

        windowrulev2 = (if hostCfg.defaultWindowRules then [
          "noshadow, floating:0" # hide shadow on floating windows

          # picture in picture windows
          "float, title:^(Picture-in-Picture)$"
          "pin, title:^(Picture-in-Picture)$"
          "keepaspectratio, title:^(Picture-in-Picture)$"
          "opaque, title:^(Picture-in-Picture)$"

          # always opaque apps
          "opaque, class:^(blender)$"
          "opaque, initialClass:^(floorp)"
          "opaque, initialClass:^(firefox)"
          "opaque, initialClass:^(chrome)"

          # fixes ardour drag and drop issues
          # thanks to github.com/catbrained for saving me hours of searching
          # https://github.com/catbrained/dotfiles/blob/50ed08e81b410addb21d7bb3f2970a9dfcd085ff/home.nix#L565
          "nofocus, class:^(Ardour-)(.*)$, title:^(Ardour)$"
          "center, class:^(Ardour-)(.*)$, initialTitle:^(Add )(.*)$, floating:1" # centers floating ardour windows

          # Godot Game Engine
          "tile, initialTitle:^(Godot)$"
          "float, initialClass:^(Godot)$, initialTitle:^(Project Manager)$"
          "opaque, initialTitle:^(Godot)$"
          "center, class:^(Godot)(.*)$, initialTitle:^(Create New Node|New Text File...|Create New Resource)$, floating:1"
          "size 1280 720, class:^(Godot)(.*)$, initialTitle:^(Create New Node|New Text File...|Create New Resource)$"
        ] else []) ++ hostCfg.windowRules;

        layerrule = (if hostCfg.defaultLayerRules then [
          "blur, ^(gtk-layer-shell)$"
          "ignorezero, ^(gtk-layer-shell)$"
          "blur, ^(launcher)$"
          "blur, notifications"
          "noanim, bar"
        ] else []) ++ hostCfg.layerRules;
      };
    };

    home.packages = builtins.attrValues { inherit (pkgs)
      networkmanagerapplet # network manager

      hyprpicker           # color picker
      grim                 # screenshot utility
      slurp                # screen region selection

      wl-clipboard         # clipboard
      playerctl            # media control utility
      pamixer              # audio device manager
      ;
    };

    services.cliphist.enable = mkDefault true;

    # do some funky stuff to get cursors and gtk working right
    # see https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#fixing-problems-with-themes
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 16;
    };
    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-mocha-mauve-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "standard";
          variant = "mocha";
        };
      };
    };
    qt = {
      enable = true;
      platformTheme.name = "kde";
    };
  };
}
