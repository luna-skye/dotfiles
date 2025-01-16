{ config, lib, helpers, ... }: let
  cfg = config.bead.hyprland;

  # Generated bindings for moving yourself and windows between workspaces using the 0-9 number row
  genWorkspaceBindings = builtins.concatLists (builtins.genList (
    x: let
      ws = toString (x + 1);
    in [
      "$mod, ${ws}, workspace, ${ws}"
      "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
    ]
  ) 10);
in {
  imports = [];


  options.bead.hyprland.keybinds = {
    enableDefault = helpers.mkBooleanOption true "Whether to use preconfigured keybindings for Hyprland";

    keys = {
      mod = helpers.mkStringOption "SUPER" "Modifier key used for most Hyprland keybinds";

      directions = {
        left  = helpers.mkStringOption "h" "Key for left navigation";
        down  = helpers.mkStringOption "l" "Key for down navigation";
        up    = helpers.mkStringOption "j" "Key for up navigation";
        right = helpers.mkStringOption "k" "Key for right navigation";
      };
      
      toggleWindowFullscreen = helpers.mkStringOption "F" "Key to toggle active window fullscreen";
      toggleWindowFloating   = helpers.mkStringOption "V" "Key to toggle active window floating";
      centerWindow           = helpers.mkStringOption "Period" "Key to center the active window";
      closeWindow            = helpers.mkStringOption "X" "Key to close the active window";

      openBrowser      = helpers.mkStringOption "B" "Key to open the configured default browser";
      openTerminal     = helpers.mkStringOption "T" "Key to open the configured default browser";
      openFileExplorer = helpers.mkStringOption "E" "Key to open the configured default browser";

      pickColor      = helpers.mkStringOption "P" "Key to start Hyprpicker color picker";
      takeScreenshot = helpers.mkStringOption "Print" "Key to take screenshots";
    };

    actions = {
      launcher = helpers.mkStringOption "walker --modules applications,finder,calc,ssh" "The command to execute when calling the application launcher";
    };

    extra = {
      bind  = helpers.mkListOfOption lib.types.str [] "Custom normal keybinds to register in Hyprland";
      bindm = helpers.mkListOfOption lib.types.str [] "Custom mouse keybinds to register in Hyprland";
      binde = helpers.mkListOfOption lib.types.str [] "Custom event keybinds to register in Hyprland";
      bindl = helpers.mkListOfOption lib.types.str [] "Custom locked keybinds to register in Hyprland";
    };
  };


  config = {
    wayland.windowManager.hyprland.settings = {
      "$mod" = cfg.keybinds.keys.mod;

      # Standard keybinds
      bind = lib.lists.optionals (cfg.keybinds.enableDefault) ([
        "$mod SHIFT, X, exit" # Exit Hyprland
        "$mod, SPACE, exec, ${cfg.keybinds.actions.launcher}" # Application Launcher

        # Window Navigation
        "$mod, ${cfg.keybinds.keys.directions.left}, movefocus, l"
        "$mod, ${cfg.keybinds.keys.directions.right}, movefocus, r"
        "$mod, ${cfg.keybinds.keys.directions.down}, movefocus, d"
        "$mod, ${cfg.keybinds.keys.directions.up}, movefocus, u"

        # Window Actions
        "$mod, ${cfg.keybinds.keys.toggleWindowFullscreen}, fullscreen"
        "$mod, ${cfg.keybinds.keys.toggleWindowFloating}, togglefloating"
        "$mod, ${cfg.keybinds.keys.centerWindow}, centerwindow"
        "$mod, ${cfg.keybinds.keys.closeWindow}, killactive"

        # Application Shortcuts
        #  TODO: figure out proper way to open default applications
        "$mod, ${cfg.keybinds.keys.openBrowser}, exec, ..."
        "$mod, ${cfg.keybinds.keys.openTerminal}, exec, ..."
        "$mod, ${cfg.keybinds.keys.openFileExplorer}, exec, ..."

        # Color Picker
        "$mod, ${cfg.keybinds.keys.pickColor}, exec, hyprpicker -a -f hex"

        # Screenshotting
        #  TODO: implement screenshotting scripts
        ", ${cfg.keybinds.keys.takeScreenshot}, exec, ..."
        "CTRL, ${cfg.keybinds.keys.takeScreenshot}, exec, ..."
        "$mod CTRL, ${cfg.keybinds.keys.takeScreenshot}, exec, ..."
      ] ++ genWorkspaceBindings) ++ cfg.keybinds.extra.bind;

      # Mouse keybinds
      bindm = lib.lists.optionals (cfg.keybinds.enableDefault) [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"

        # unbind some dumb mouse keys
        ", mouse:274, " # middle mouse key
        ", mouse_left, " # middle mouse left
        ", mouse_right, " # middle mouse right
      ] ++ cfg.keybinds.extra.bindm;

      # Event keybinds
      binde = lib.lists.optionals (cfg.keybinds.enableDefault) [
        # Volume Controls
        ", XF86AudioMicMute, exec, pamixer --default-source -t"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioLowerVolume, exec, pamixer -i 5"
      ] ++ cfg.keybinds.extra.binde;

      # Locked keybinds, persisting despite active input inhibitors
      bindl = lib.lists.optionals (cfg.keybinds.enableDefault) [
        # Media Controls
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
      ] ++ cfg.keybinds.extra.bindl;
    };
  };
}
