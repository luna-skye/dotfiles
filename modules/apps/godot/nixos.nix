{ helpers, pkgs, ... }:

{
  imports = [];

  options.zen.apps.godot = {
    enable = helpers.mkBooleanOption false "Whether to install the Godot Game Engine";
  };

  config = {};
}

