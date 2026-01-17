{ config, lib, pkgs, helpers, ... }:


let
  cfg = config.zen.apps.blender;

in {
  options.zen.apps.blender = {
    enable = helpers.mkBooleanOption false "Whether to enable the Blender3D modeling software";
    useHIP = helpers.mkBooleanOption true "Whether to configure Blender for AMD GPUs through the HIP driver";
  };

  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = [ pkgs.blender ];
    nixpkgs.config.rocmSupport = cfg.useHIP;
  };
}
