{ config, lib, helpers }:


let
  cfg = config.zen.session.niri;

in {
  options = {};

  output = ''
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
  '';
}
