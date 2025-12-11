{ inputs, osConfig, config, lib, helpers, ... }:


let
  stellae = inputs.stellae-nix.lib;
  colors = config.zen.theme.palette;

  cfg = config.zen.session.niri;
  hostCfg = osConfig.zen.session.niri;

  monitors = builtins.concatStringsSep "\n" (map (m:
    let
      pos = builtins.match "([0-9]+)x([0-9]+)" m.offset;
      x = builtins.elemAt pos 0;
      y = builtins.elemAt pos 1;
    in ''
      output "${m.name}" {
        mode "${m.resolution}@${toString m.refreshRate}"
        scale 1
        transform "normal"
        position x=${x} y=${y}
      }
    ''
  ) osConfig.zen.session.monitors);

in {
  options.zen.session.niri = {
    layout = {
      default-window-size = helpers.mkNumberOption 0.5 "Default proportional size of windows";
    };

    style = {
      window = {
        margin = {
          top    = helpers.mkNumberOption 8 "Top margin of windows";
          right  = helpers.mkNumberOption 8 "Right margin of windows";
          bottom = helpers.mkNumberOption 8 "Bottom margin of windows";
          left   = helpers.mkNumberOption 8 "Left margin of windows";
        };

        border-size = helpers.mkNumberOption 2 "Pixel width for borders around window";
        gaps   = helpers.mkNumberOption 8 "Pixel width for gaps between windows";
        radius = helpers.mkNumberOption 8 "Roundness, in pixels, of windows";

        active-opacity   = helpers.mkNumberOption 1.00 "Opacity of active windows";
        inactive-opacity = helpers.mkNumberOption 0.95 "Opacity of inactive windows";
      };

      tab = {
        size   = helpers.mkNumberOption 8 "Size of tab indicators, in pixels";
        gaps   = helpers.mkNumberOption 8 "Width of gaps between tab indicators, in pixels";
        radius = helpers.mkNumberOption 8 "Border radius for tab indicators, in pixels";
      };

      active-color-1 = lib.mkOption {
        type = lib.types.attrs;
        default = colors.primary;
        description = "Color for active window borders and tabs";
      };
      active-color-2 = lib.mkOption {
        type = lib.types.attrs;
        default = colors.secondary;
        description = "Color for active window borders and tabs";
      };
      inactive-color = lib.mkOption {
        type = lib.types.attrs;
        default = colors.surface.surface1;
        description = "Color for active window borders and tabs";
      };

      shadow = {
        enable = helpers.mkBooleanOption true        "Whether to enable shadows around windows";
        size   = helpers.mkNumberOption  16          "Size of the shadow around windows";
        spread = helpers.mkNumberOption  4           "Spread of the shadow around windows";
        color  = lib.mkOption {
          type = lib.types.attrs;
          default = colors.surface.crust;
          description = "Color of the shadow around windows";
        };
      };
    };

    window-rules = {};

    keybinds = {};

    screenshot-path = helpers.mkStringOption "~/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H-%M-%S.png" "Where to store screenshots on disk and with what string format";
  };

  config = lib.mkIf (hostCfg.enable) {
    home.file.".config/niri/config.kdl".text = ''
      // STARTUP //
      environment {
        QT_QPA_PLATFORM "wayland;xcb"
        QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        QT_QPA_PLATFORMTHEME "qt6ct-kde"
        GDK_BACKEND "wayland,x11"
        // GTK_THEME "Sweet-Dark"
        DISPLAY ":2"
      }

      spawn-at-startup "nm-applet"
      spawn-at-startup "xwayland-satellite" ":2"
      ${if (osConfig.zen.services.swww.enable) then ''spawn-at-startup "bash" "-c" "swww-daemon"'' else ""}


      // STYLE //
      layout {
        gaps ${toString cfg.style.window.gaps}
        center-focused-column "on-overflow"
        always-center-single-column

        default-column-display "tabbed"
        tab-indicator {
          hide-when-single-tab
          position "top"
          place-within-column
          length total-proportion=0.985
          width ${toString cfg.style.tab.size}
          gap ${toString cfg.style.tab.gaps}
          corner-radius ${toString cfg.style.tab.radius}
          gaps-between-tabs ${toString cfg.style.tab.gaps}
          active-color "#${stellae.colors.hslToHex cfg.style.active-color-1}"
          inactive-color "#${stellae.colors.hslToHex cfg.style.inactive-color}"
        }

        default-column-width { proportion ${toString cfg.layout.default-window-size}; }
        preset-column-widths {
          proportion 0.33333
          proportion 0.5
          proportion 0.66666
        }

        focus-ring { off; }
        border {
          width ${toString cfg.style.window.border-size}
          active-gradient from="#${stellae.colors.hslToHex cfg.style.active-color-1}" to="#${stellae.colors.hslToHex cfg.style.active-color-2}" angle=45
          inactive-gradient from="#${stellae.colors.hslToHex cfg.style.inactive-color}" to="#${stellae.colors.hslToHex cfg.style.inactive-color}" angle=45 relative-to="workspace-view"
        }

        struts {
          left   ${toString cfg.style.window.margin.left}
          right  ${toString cfg.style.window.margin.right}
          top    ${toString cfg.style.window.margin.top}
          bottom ${toString cfg.style.window.margin.bottom}
        }
        shadow {
          ${if (cfg.style.shadow.enable) then "on" else "off"}
          softness ${toString cfg.style.shadow.size}
          spread ${toString cfg.style.shadow.spread}
          color "#${stellae.colors.hslToHex cfg.style.shadow.color}"
        }
      }

      animations {
        slowdown 0.8
      }

      // Omit client-side decorations if possible, removing some rounded corners
      prefer-no-csd

      // Where screenshots are saved and with what string format
      screenshot-path "${cfg.screenshot-path}"


      // MONITORS //
      ${monitors}


      // WINDOW RULES //
      // Active Window
      window-rule {
        geometry-corner-radius ${toString cfg.style.window.radius}
        clip-to-geometry true
        draw-border-with-background false
        opacity ${toString cfg.style.window.active-opacity}
      }

      // Application Rules
      window-rule {
        match app-id="godot"
        open-maximized true
        opacity 1.0
      }
      window-rule {
        match app-id="blender"
        open-maximized true
        opacity 1.0
      }
      window-rule {
        match app-id="zen-twilight"
        open-maximized true
        opacity 1.0
      }
      window-rule {
        match app-id="kitty"
        opacity 0.98
      }

      // Inactive Window
      window-rule {
        match is-focused=false
        opacity ${toString cfg.style.window.inactive-opacity}
      }


      // INPUT //
      input {
        /-keyboard { xkb {}; }

        touchpad {
          // off
          tap
          natural-scroll
          accel-speed 0.2
          scroll-method "two-finger"
        }

        mouse {
          // off
          // natural-scroll
          // accel-speed 0.2
          // accel-profile "flat"
          // scroll-method "no-scroll"
        }

        focus-follows-mouse
      }


      // KEYBINDS //
      hotkey-overlay { skip-at-startup; }

      binds {
        // laptop keys
        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl"      "set" "+5%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "-n" "set" "5%-"; }
        XF86AudioRaiseVolume  allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"; }
        XF86AudioLowerVolume  allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"; }
        XF86AudioMute         allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@"   "toggle"; }
        XF86AudioMicMute      allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        Mod+Shift+Slash { show-hotkey-overlay; }

        // programs
        Mod+Backspace { spawn "tofi-drun" "--drun-launch=true"; }
        Mod+Period { spawn "/nix/store/zky49vh5n3cc0qkbrw2yqq6dl6y18k4z-config-menu"; }
        Mod+B { spawn "zen-twilight"; }
        Mod+E { spawn "dolphin"; }
        Mod+T { spawn "kitty"; }

        // windows
        Mod+X hotkey-overlay-title="Close Window" { close-window; }

        Mod+Left  hotkey-overlay-title="Focus Window Left"  { focus-column-left; }
        Mod+Right hotkey-overlay-title="Focus Window Right" { focus-column-right; }
        Mod+Down  hotkey-overlay-title="Focus Window Down"  { focus-window-or-workspace-down; }
        Mod+Up    hotkey-overlay-title="Focus Window Up"    { focus-window-or-workspace-up; }
        Mod+H hotkey-overlay-title="Focus Window Right" { focus-column-right; }
        Mod+L hotkey-overlay-title="Focus Window Left"  { focus-column-left; }
        Mod+J hotkey-overlay-title="Focus Window Down"  { focus-window-or-workspace-down; }
        Mod+K hotkey-overlay-title="Focus Window Up"    { focus-window-or-workspace-up; }

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
  };
}
