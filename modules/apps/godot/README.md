# 🎮 Godot Game Engine
Godot is an open-source game engine capable of 2D & 3D game development.

> ℹ️ NOTE
> This configuration is often locked to a specific version within Nixpkgs, to avoid constantly requiring projects to be ported to new versions. A more elegant solution is to use shells or Nix Flakes to control versioned dependencies on a per-project basis.
> 
> The currently locked version is Godot 4.2.1.

## External Links
- [Official Webpage](https://godotengine.org/)

## Options
Options can be accessed from the `zen.apps.godot` config path.

| Name     | Type      | Default | Scope      | Description                              |
|----------|-----------|---------|------------|------------------------------------------|
| `enable` | `boolean` | `false` | NixOS Host | Whether to install the Godot Game Engine |
