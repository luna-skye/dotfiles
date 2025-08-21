{ config, osConfig, lib, helpers, ... }:

let
  cfg = config.zen.session.hyprland;

  # Generated bindings for moving yourself and windows between workspaces using the 0-9 number row
  genWorkspaceBindings = builtins.concatLists (builtins.genList (
    x: let
      ws = let c = (x + 1) / 10;
      in builtins.toString (x + 1 - (c * 10));
    in [
      "$mod, ${ws}, workspace, ${toString (x + 1)}"
      "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
    ]
    ) 10
  );

in {
  imports = [];

  options.zen.session.hyprland.keybinds = {
    enableDefault = helpers.mkBooleanOption true "Whether to use preconfigured keybindings for Hyprland";

    keys = {
      mod = helpers.mkStringOption "SUPER" "Modifier key used for most Hyprland keybinds";

      directions = {
        left  = helpers.mkStringOption "h" "Key for left navigation";
        right = helpers.mkStringOption "l" "Key for right navigation";
        down  = helpers.mkStringOption "j" "Key for down navigation";
        up    = helpers.mkStringOption "k" "Key for up navigation";
      };
      
      toggleWindowFullscreen = helpers.mkStringOption "F" "Key to toggle active window fullscreen";
      toggleWindowFloating   = helpers.mkStringOption "V" "Key to toggle active window floating";
      centerWindow           = helpers.mkStringOption "C" "Key to center the active window";
      closeWindow            = helpers.mkStringOption "X" "Key to close the active window";

      applicationMenu  = helpers.mkStringOption "SPACE" "Key to open the application dmenu";
      openConfigMenu   = helpers.mkStringOption "Period" "Key to open the custom configuration dmenu";
      openBrowser      = helpers.mkStringOption "B" "Key to open the configured default browser";
      openTerminal     = helpers.mkStringOption "T" "Key to open the configured default browser";
      openFileExplorer = helpers.mkStringOption "E" "Key to open the configured default browser";
      pickColor        = helpers.mkStringOption "P" "Key to start Hyprpicker color picker";
      takeScreenshot   = helpers.mkStringOption "Print" "Key to take screenshots";
    };

    actions = {
      applicationMenu = helpers.mkStringOption "tofi-drun | xargs -0 hyprctl dispatch exec --" "The command to execute when calling the application launcher";
      openBrowser = helpers.mkStringOption "firefox" "Command to execute when opening the browser";
      openTerminal = helpers.mkStringOption "kitty" "Command to execute when opening the terminal";
      openFileExplorer = helpers.mkStringOption "dolphin" "Command to execute when opening the terminal";
      pickColor = helpers.mkStringOption "hyprpicker -a -f hex" "Command to execute when opening the color picker";

      # TODO: Improve screenshotting utilities, make sure they're not reliant on specific systems, monitors, or tools
      takeScreenshot = helpers.mkStringOption /* bash */ ''
        grim -g "$(slurp -d -b "000000ef" -c "ffffff00")" - | ifne bash -c "tee > $HOME"/Pictures/Screenshots/Screenshot_"$(date +"%Y-%m-%d_%H-%M-%S")".png" >(wl-copy -t image/png)"
      '' "Command to execute when trigger screenshot keybind";

      takeFullScreenshot = helpers.mkStringOption /* bash */ ''
        grim -o DP-1 - | ifne bash -c "tee > $HOME"/Pictures/Screenshots/Screenshot_"$(date +"%Y-%m-%d_%H-%M-%S")".png" >(wl-copy -t image/png)"
      '' "Command to execute when triggering fullscreen screenshot";

      takeWindowScreenshot = helpers.mkStringOption /* bash */ ''
        grim -g $(hyprctl clients -j | jq '.[] | select(.focusHistoryID == 0) | "\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])"') - | ifne bash -c "tee > $HOME"/Pictures/Screenshots/Screenshot_"$(date +"%Y-%m-%d_%H-%M-%S")".png" >(wl-copy -t image/png)"
      '' "Command to execute when triggering screenshot of currently active window";
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
        "$mod, ${cfg.keybinds.keys.applicationMenu}, exec, ${cfg.keybinds.actions.applicationMenu}" # Application Launcher

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
        "$mod, ${cfg.keybinds.keys.openBrowser}, exec, ${cfg.keybinds.actions.openBrowser}"
        "$mod, ${cfg.keybinds.keys.openTerminal}, exec, ${cfg.keybinds.actions.openTerminal}"
        "$mod, ${cfg.keybinds.keys.openFileExplorer}, exec, ${cfg.keybinds.actions.openFileExplorer}"

        # Color Picker
        "$mod, ${cfg.keybinds.keys.pickColor}, exec, ${cfg.keybinds.actions.pickColor}"

        # Screenshotting
        ", ${cfg.keybinds.keys.takeScreenshot}, exec, ${cfg.keybinds.actions.takeScreenshot}"
        "CTRL, ${cfg.keybinds.keys.takeScreenshot}, exec, ${cfg.keybinds.actions.takeFullScreenshot}"
        "$mod CTRL, ${cfg.keybinds.keys.takeScreenshot}, exec, ${cfg.keybinds.actions.takeWindowScreenshot}"
      ] ++ genWorkspaceBindings ++
        lib.lists.optional (osConfig.zen.services.tofi.enable) "$mod, ${cfg.keybinds.keys.openConfigMenu}, exec, ${config.zen.scripts.configMenu}"
      ) ++ cfg.keybinds.extra.bind;

      # Mouse keybinds
      bindm = lib.lists.optionals (cfg.keybinds.enableDefault) [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        # ", mouse_left, " # middle mouse left
        # ", mouse_right, " # middle mouse right
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
