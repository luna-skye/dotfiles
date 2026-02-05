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
      match app-id="zen-twilight"
      match app-id="blender"
      match app-id="Godot"
      open-maximized true
      opacity 1.0
    }
    window-rule {
      match title="Open File"
      match title="Open Folder"
      match app-id="Godot" title="Create New Node"
      match app-id="Godot" title="Project Settings"
      match app-id="Godot" title="Editor Settings"
      match app-id="Godot" title="Export"
      match app-id="Godot" title="Run Instances"
      match app-id="Godot" title="Attach Node Script"
      match app-id="Godot" title="Select Scene"
      match app-id="Godot" title="Event Configuration"
      match app-id="Godot" title="Save"
      match app-id="Godot" title="Please Confirm"
      match app-id="Godot" title="Pick Root Node Type"
      match app-id="Godot" title="(DEBUG)"
      open-maximized false
      open-floating true
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

    // Picture-in-Picture
    window-rule {
      match title="Picture-in-Picture"
      open-focused false
      open-floating true
      default-floating-position x=32 y=32 relative-to="bottom-left"
      default-column-width { fixed 480; }
      default-window-height { fixed 270; }
    }
  '';
}
