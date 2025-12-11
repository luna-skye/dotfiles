{ config, lib, helpers }:


let
  cfg = config.zen.session.niri;

in {
  options = {};

  output = ''
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

      Mod+Shift+Slash { show-hotkey-overlay; }
      Mod+Escape { open-overview; }

      // programs
      Mod+Backspace { spawn "tofi-drun" "--drun-launch=true"; }
      Mod+Period { spawn "${config.zen.scripts.configMenu}"; }
      Mod+B { spawn "zen-twilight"; }
      Mod+E { spawn "dolphin"; }
      Mod+T { spawn "kitty"; }

      // windows
      Mod+Left  hotkey-overlay-title="Focus Window Left"  { focus-column-left; }
      Mod+Right hotkey-overlay-title="Focus Window Right" { focus-column-right; }
      Mod+Down  hotkey-overlay-title="Focus Window Down"  { focus-window-or-workspace-down; }
      Mod+Up    hotkey-overlay-title="Focus Window Up"    { focus-window-or-workspace-up; }
      Mod+H hotkey-overlay-title="Focus Window Right" { focus-column-right; }
      Mod+L hotkey-overlay-title="Focus Window Left"  { focus-column-left; }
      Mod+J hotkey-overlay-title="Focus Window Down"  { focus-window-or-workspace-down; }
      Mod+K hotkey-overlay-title="Focus Window Up"    { focus-window-or-workspace-up; }
      Mod+X hotkey-overlay-title="Close Window" { close-window; }

      Mod+Home  { focus-column-first; }
      Mod+End   { focus-column-last; }

      Mod+Shift+Left  { move-column-left; }
      Mod+Shift+Right { move-column-right; }
      Mod+Shift+Down  { move-column-to-workspace-down; }
      Mod+Shift+Up    { move-column-to-workspace-up; }
      Mod+Shift+L { move-column-left; }
      Mod+Shift+H { move-column-right; }
      Mod+Shift+J { move-column-to-workspace-down; }
      Mod+Shift+K { move-column-to-workspace-up; }

      Mod+Alt+Left  hotkey-overlay-title="Move into Column Left"  { consume-or-expel-window-left; }
      Mod+Alt+Right hotkey-overlay-title="Move into Column Right" { consume-or-expel-window-right; }
      Mod+Alt+Down  hotkey-overlay-title="Move into Column Down"  { move-window-down-or-to-workspace-down; }
      Mod+Alt+Up    hotkey-overlay-title="Move into Column Up"    { move-window-up-or-to-workspace-up; }
      Mod+Alt+L hotkey-overlay-title="Move into Column Left"  { consume-or-expel-window-left; }
      Mod+Alt+H hotkey-overlay-title="Move into Column Right" { consume-or-expel-window-right; }
      Mod+Alt+J hotkey-overlay-title="Move into Column Down"  { move-window-down-or-to-workspace-down; }
      Mod+Alt+K hotkey-overlay-title="Move into Column Up"    { move-window-up-or-to-workspace-up; }

      Mod+Shift+Home { move-column-to-first; }
      Mod+Shift+End  { move-column-to-last; }

      Mod+Ctrl+Left  { focus-monitor-left; }
      Mod+Ctrl+Right { focus-monitor-right; }
      Mod+Ctrl+Down  { focus-monitor-up; }
      Mod+Ctrl+Up    { focus-monitor-down; }
      Mod+Ctrl+L { focus-monitor-left; }
      Mod+Ctrl+H { focus-monitor-right; }
      Mod+Ctrl+J { focus-monitor-up; }
      Mod+Ctrl+K { focus-monitor-down; }

      Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
      Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+L { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+H { move-column-to-monitor-right; }
      Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+K { move-column-to-monitor-up; }

      // touchpad window movement
      Mod+Shift+TouchpadScrollUp    cooldown-ms=200 { move-column-to-workspace-up; }
      Mod+Shift+TouchpadScrollDown  cooldown-ms=200 { move-column-to-workspace-down; }
      Mod+Shift+TouchpadScrollRight cooldown-ms=200 { move-column-right; }
      Mod+Shift+TouchpadScrollLeft  cooldown-ms=200 { move-column-left; }

      Mod+Alt+TouchpadScrollLeft    cooldown-ms=200 { consume-or-expel-window-left; }
      Mod+Alt+TouchpadScrollRight   cooldown-ms=200 { consume-or-expel-window-right; }
      Mod+Alt+TouchpadScrollDown    cooldown-ms=200 { move-window-down-or-to-workspace-down; }
      Mod+Alt+TouchpadScrollUp      cooldown-ms=200 { move-window-up-or-to-workspace-up; }

      // workspaces
      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }
      Mod+Ctrl+1 { move-column-to-workspace 1; }
      Mod+Ctrl+2 { move-column-to-workspace 2; }
      Mod+Ctrl+3 { move-column-to-workspace 3; }
      Mod+Ctrl+4 { move-column-to-workspace 4; }
      Mod+Ctrl+5 { move-column-to-workspace 5; }
      Mod+Ctrl+6 { move-column-to-workspace 6; }
      Mod+Ctrl+7 { move-column-to-workspace 7; }
      Mod+Ctrl+8 { move-column-to-workspace 8; }
      Mod+Ctrl+9 { move-column-to-workspace 9; }

      Mod+V { switch-focus-between-floating-and-tiling; }
      Mod+Alt+V { toggle-window-floating; }
      Mod+R { switch-preset-column-width; }
      Mod+Shift+R hotkey-overlay-title="Expand Column to Fill Available Width" { expand-column-to-available-width; }
      Mod+F { maximize-column; }
      Mod+Ctrl+F { fullscreen-window; }
      Mod+C hotkey-overlay-title="Center Column" { center-column; }

      Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }

      Mod+Alt+Escape { quit; }
    }
  '';
}
