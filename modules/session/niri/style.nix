{ config, lib, helpers, stellae }:


let
  cfg = config.zen.session.niri;
  colors = stellae.lib.elementToFormattedHex config.zen.theme.element;

in {
  options = {
    layout = {
      default-window-size = helpers.mkNumberOption 0.5 "Default proportional size of windows";
    };

    window = {
      margin = {
        top    = helpers.mkNumberOption 4 "Top margin of windows";
        right  = helpers.mkNumberOption 4 "Right margin of windows";
        bottom = helpers.mkNumberOption 4 "Bottom margin of windows";
        left   = helpers.mkNumberOption 4 "Left margin of windows";
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
      type = lib.types.str;
      default = colors.tokens.primary;
      description = "Color for active window borders and tabs";
    };
    active-color-2 = lib.mkOption {
      type = lib.types.str;
      default = colors.tokens.secondary;
      description = "Color for active window borders and tabs";
    };
    inactive-color = lib.mkOption {
      type = lib.types.str;
      default = colors.surface.surface1;
      description = "Color for active window borders and tabs";
    };

    shadow = {
      enable = helpers.mkBooleanOption true        "Whether to enable shadows around windows";
      size   = helpers.mkNumberOption  16          "Size of the shadow around windows";
      spread = helpers.mkNumberOption  4           "Spread of the shadow around windows";
      color  = lib.mkOption {
        type = lib.types.str;
        default = colors.surface.crust;
        description = "Color of the shadow around windows";
      };
    };
  };

  output = ''
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
        active-color "${cfg.style.active-color-1}"
        inactive-color "${cfg.style.inactive-color}"
      }

      default-column-width { proportion ${toString cfg.style.layout.default-window-size}; }
      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66666
      }

      focus-ring { off; }
      border {
        width ${toString cfg.style.window.border-size}
        active-gradient from="${cfg.style.active-color-1}" to="${cfg.style.active-color-2}" angle=45
        inactive-gradient from="${cfg.style.inactive-color}" to="${cfg.style.inactive-color}" angle=45 relative-to="workspace-view"
      }

      struts {
        left   ${toString cfg.style.window.margin.left}
        right  ${toString cfg.style.window.margin.right}
        top    ${toString cfg.style.window.margin.top}
        bottom ${toString cfg.style.window.margin.bottom}
      }
      shadow {
        ${if (cfg.style.shadow.enable) then "// off" else "off"}
        softness ${toString cfg.style.shadow.size}
        spread ${toString cfg.style.shadow.spread}
        color "${cfg.style.shadow.color}"
      }
    }

    overview {
      zoom 0.5
      backdrop-color "${colors.surface.crust}"
      workspace-shadow {
        ${if (cfg.style.shadow.enable) then "// off" else "off"}
        softness ${toString cfg.style.shadow.size}
        spread ${toString cfg.style.shadow.spread}
        color "${cfg.style.shadow.color}"
      }
    }

    animations {
      slowdown 0.8
    }

    cursor {
      xcursor-theme "catppuccin-mocha-mauve-cursors"
      xcursor-size 24
      // hide-when-typing
      // hide-after-inactive-ms 1000
    }

    // Omit client-side decorations if possible, removing some rounded corners
    prefer-no-csd
  '';
}
