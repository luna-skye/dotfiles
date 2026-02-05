{ config, lib, helpers }:

#  TODO: Implement scrollwheel navigation

let
  cfg = config.zen.session.niri;

in {
  options = {
    keys = {
      mod = helpers.mkStringOption "Mod" "Which key acts as the mod key";
      open-overview = helpers.mkStringOption "Escape" "Key which opens the overview";
      hotkey-overlay = helpers.mkStringOption "Shift+Slash" "Key which opens the hotkey-overlay";
      application-launcher = helpers.mkStringOption "Backspace" "Key which opens the application launcher";
      config-menu = helpers.mkStringOption "Period" "Key which opens the tofi config menu";

      browser = helpers.mkStringOption "B" "Key which opens the configured browser";
      explorer = helpers.mkStringOption "E" "Key which opens the configured file explorer";
      terminal = helpers.mkStringOption "T" "Key which opens the configured terminal";

      toggle-floating = helpers.mkStringOption "V" "Key which toggles active window floating/tiling state";
      toggle-maximize = helpers.mkStringOption "F" "Key which toggles active window maximize";
      toggle-fullscreen = helpers.mkStringOption "Shift+F" "Key which toggles active window fullscreen";
      switch-width-preset = helpers.mkStringOption "R" "Key which toggles active window width preset";
      close-window = helpers.mkStringOption "X" "Key which closes the active window";
    };

    actions = {
      browser = helpers.mkStringOption "zen-twilight" "Application to spawn as the browser";
      explorer = helpers.mkStringOption "dolphin" "Application to spawn as the file explorer";
      terminal = helpers.mkStringOption "kitty" "Application to spawn as the terminal";
    };
  };

  output = let
    inherit (cfg.keybinds) keys actions;
  in ''
    hotkey-overlay {
      skip-at-startup
      hide-not-bound
    }

    binds {
      // laptop keys
      XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl"      "set" "+5%"; }
      XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "-n" "set" "5%-"; }
      XF86AudioRaiseVolume  allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"; }
      XF86AudioLowerVolume  allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"; }
      XF86AudioMute         allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@"   "toggle"; }
      XF86AudioMicMute      allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

      ${keys.mod}+${keys.hotkey-overlay} { show-hotkey-overlay; }
      ${keys.mod}+${keys.open-overview} { open-overview; }

      // programs
      ${keys.mod}+${keys.application-launcher} { spawn "tofi-drun" "--drun-launch=true"; }
      ${keys.mod}+${keys.config-menu} { spawn "${config.zen.scripts.configMenu}"; }
      ${keys.mod}+${keys.browser} { spawn "${actions.browser}"; }
      ${keys.mod}+${keys.explorer} { spawn "${actions.explorer}"; }
      ${keys.mod}+${keys.terminal} { spawn "${actions.terminal}"; }

      // windows
      ${keys.mod}+Left  hotkey-overlay-title="Focus Window Left"  { focus-column-left; }
      ${keys.mod}+Right hotkey-overlay-title="Focus Window Right" { focus-column-right; }
      ${keys.mod}+Down  hotkey-overlay-title="Focus Window Down"  { focus-window-or-workspace-down; }
      ${keys.mod}+Up    hotkey-overlay-title="Focus Window Up"    { focus-window-or-workspace-up; }
      ${keys.mod}+H hotkey-overlay-title="Focus Window Right" { focus-column-right; }
      ${keys.mod}+L hotkey-overlay-title="Focus Window Left"  { focus-column-left; }
      ${keys.mod}+J hotkey-overlay-title="Focus Window Down"  { focus-window-or-workspace-down; }
      ${keys.mod}+K hotkey-overlay-title="Focus Window Up"    { focus-window-or-workspace-up; }
      ${keys.mod}+${keys.close-window} hotkey-overlay-title="Close Window" { close-window; }

      ${keys.mod}+Home  { focus-column-first; }
      ${keys.mod}+End   { focus-column-last; }

      ${keys.mod}+Shift+Left  { move-column-left; }
      ${keys.mod}+Shift+Right { move-column-right; }
      ${keys.mod}+Shift+Down  { move-column-to-workspace-down; }
      ${keys.mod}+Shift+Up    { move-column-to-workspace-up; }
      ${keys.mod}+Shift+L { move-column-left; }
      ${keys.mod}+Shift+H { move-column-right; }
      ${keys.mod}+Shift+J { move-column-to-workspace-down; }
      ${keys.mod}+Shift+K { move-column-to-workspace-up; }

      ${keys.mod}+Alt+Left  hotkey-overlay-title="Move into Column Left"  { consume-or-expel-window-left; }
      ${keys.mod}+Alt+Right hotkey-overlay-title="Move into Column Right" { consume-or-expel-window-right; }
      ${keys.mod}+Alt+Down  hotkey-overlay-title="Move into Column Down"  { move-window-down-or-to-workspace-down; }
      ${keys.mod}+Alt+Up    hotkey-overlay-title="Move into Column Up"    { move-window-up-or-to-workspace-up; }
      ${keys.mod}+Alt+L hotkey-overlay-title="Move into Column Left"  { consume-or-expel-window-left; }
      ${keys.mod}+Alt+H hotkey-overlay-title="Move into Column Right" { consume-or-expel-window-right; }
      ${keys.mod}+Alt+J hotkey-overlay-title="Move into Column Down"  { move-window-down-or-to-workspace-down; }
      ${keys.mod}+Alt+K hotkey-overlay-title="Move into Column Up"    { move-window-up-or-to-workspace-up; }

      ${keys.mod}+Shift+Home { move-column-to-first; }
      ${keys.mod}+Shift+End  { move-column-to-last; }

      ${keys.mod}+Ctrl+Left  { focus-monitor-left; }
      ${keys.mod}+Ctrl+Right { focus-monitor-right; }
      ${keys.mod}+Ctrl+Down  { focus-monitor-up; }
      ${keys.mod}+Ctrl+Up    { focus-monitor-down; }
      ${keys.mod}+Ctrl+L { focus-monitor-left; }
      ${keys.mod}+Ctrl+H { focus-monitor-right; }
      ${keys.mod}+Ctrl+J { focus-monitor-up; }
      ${keys.mod}+Ctrl+K { focus-monitor-down; }

      ${keys.mod}+Shift+Ctrl+Left  { move-column-to-monitor-left; }
      ${keys.mod}+Shift+Ctrl+Right { move-column-to-monitor-right; }
      ${keys.mod}+Shift+Ctrl+Down  { move-column-to-monitor-down; }
      ${keys.mod}+Shift+Ctrl+Up    { move-column-to-monitor-up; }
      ${keys.mod}+Shift+Ctrl+L { move-column-to-monitor-left; }
      ${keys.mod}+Shift+Ctrl+H { move-column-to-monitor-right; }
      ${keys.mod}+Shift+Ctrl+J { move-column-to-monitor-down; }
      ${keys.mod}+Shift+Ctrl+K { move-column-to-monitor-up; }

      // touchpad window movement
      ${keys.mod}+Shift+TouchpadScrollUp    cooldown-ms=200 { move-column-to-workspace-up; }
      ${keys.mod}+Shift+TouchpadScrollDown  cooldown-ms=200 { move-column-to-workspace-down; }
      ${keys.mod}+Shift+TouchpadScrollRight cooldown-ms=200 { move-column-right; }
      ${keys.mod}+Shift+TouchpadScrollLeft  cooldown-ms=200 { move-column-left; }

      ${keys.mod}+Alt+TouchpadScrollLeft    cooldown-ms=200 { consume-or-expel-window-left; }
      ${keys.mod}+Alt+TouchpadScrollRight   cooldown-ms=200 { consume-or-expel-window-right; }
      ${keys.mod}+Alt+TouchpadScrollDown    cooldown-ms=200 { move-window-down-or-to-workspace-down; }
      ${keys.mod}+Alt+TouchpadScrollUp      cooldown-ms=200 { move-window-up-or-to-workspace-up; }

      // workspaces
      ${keys.mod}+1 { focus-workspace 1; }
      ${keys.mod}+2 { focus-workspace 2; }
      ${keys.mod}+3 { focus-workspace 3; }
      ${keys.mod}+4 { focus-workspace 4; }
      ${keys.mod}+5 { focus-workspace 5; }
      ${keys.mod}+6 { focus-workspace 6; }
      ${keys.mod}+7 { focus-workspace 7; }
      ${keys.mod}+8 { focus-workspace 8; }
      ${keys.mod}+9 { focus-workspace 9; }
      ${keys.mod}+Shift+1 { move-column-to-workspace 1; }
      ${keys.mod}+Shift+2 { move-column-to-workspace 2; }
      ${keys.mod}+Shift+3 { move-column-to-workspace 3; }
      ${keys.mod}+Shift+4 { move-column-to-workspace 4; }
      ${keys.mod}+Shift+5 { move-column-to-workspace 5; }
      ${keys.mod}+Shift+6 { move-column-to-workspace 6; }
      ${keys.mod}+Shift+7 { move-column-to-workspace 7; }
      ${keys.mod}+Shift+8 { move-column-to-workspace 8; }
      ${keys.mod}+Shift+9 { move-column-to-workspace 9; }

      ${keys.mod}+${keys.toggle-floating} { toggle-window-floating; }
      ${keys.mod}+Shift+V { switch-focus-between-floating-and-tiling; }

      ${keys.mod}+${keys.switch-width-preset} { switch-preset-column-width; }
      ${keys.mod}+Shift+R hotkey-overlay-title="Expand Column to Fill Available Width" { expand-column-to-available-width; }

      ${keys.mod}+${keys.toggle-maximize} { maximize-column; }
      ${keys.mod}+${keys.toggle-fullscreen} { fullscreen-window; }
      ${keys.mod}+C hotkey-overlay-title="Center Column" { center-column; }

      Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }

      Mod+Alt+Escape { quit; }
    }
  '';
}
