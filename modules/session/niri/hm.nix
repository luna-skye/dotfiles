{ osConfig, config, pkgs, lib, helpers, stellae, ... }:

#  TODO: Switch to Niri flake
#  TODO: Fix GTK/QT Themes

let
  cfg = config.zen.session.niri;
  hostCfg = osConfig.zen.session.niri;

  # config from submodules
  keybinds     = import ./keybinds.nix     { inherit config lib helpers; };
  style        = import ./style.nix        { inherit config lib helpers  stellae; };
  window-rules = import ./window-rules.nix { inherit config lib helpers; };

  # generate monitor config from session nix cfg
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
    screenshot-path = helpers.mkStringOption "~/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H-%M-%S.png" "Where to store screenshots on disk and with what string format";

    window-rules = window-rules.options;
    keybinds = keybinds.options;
    style = style.options;
  };

  config = lib.mkIf (hostCfg.enable) {
    # NIRI CONFIG FILE
    home.file.".config/niri/config.kdl".text = ''
      // STARTUP //
      environment {
        QT_QPA_PLATFORM "wayland;xcb"
        QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        QT_QPA_PLATFORMTHEME "qt6ct"
        QT_QPA_PLATFORMTHEME_QT6 "qt6ct"

        GDK_BACKEND "wayland,x11"
        GTK_THEME "catppuccin-mocha-mauve-standard"
        DISPLAY ":2"
      }

      spawn-at-startup "nm-applet"
      spawn-at-startup "xwayland-satellite" ":2"
      ${if (osConfig.zen.services.noctalia-shell.enable) then ''spawn-at-startup "noctalia-shell"'' else ""}
      ${if (osConfig.zen.services.swww.enable) then ''spawn-at-startup "bash" "-c" "swww-daemon"'' else ""}

      // STYLE //
      ${style.output}

      // Where screenshots are saved and with what string format
      screenshot-path "${cfg.screenshot-path}"

      // MONITORS //
      ${monitors}

      // WINDOW RULES //
      ${window-rules.output}

      // INPUT //
      input {
        /-keyboard { xkb {}; }

        touchpad {
          // off
          tap
          // natural-scroll
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

        // focus-follows-mouse
      }

      // KEYBINDS //
      ${keybinds.output}
    '';


    home.packages = [
      pkgs.networkmanagerapplet
      pkgs.kdePackages.qt6ct
    ];

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 24;
    };

    # GTK Theme
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
    xdg.configFile = let
      gtkPath = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}";
    in {
      "gtk-4.0/assets".source = "${gtkPath}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${gtkPath}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${gtkPath}/gtk-4.0/gtk-dark.css";
    };

    # qt = {
    #   enable = true;
    #   platformTheme.name = "qtct";
    #   style = {
    #     package = pkgs.catppuccin-qt5ct;
    #     name = "catppuccin-mocha-mauve";
    #   };
    # };
  };
}
