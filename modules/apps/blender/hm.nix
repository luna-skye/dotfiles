{ config, lib, helpers, pkgs, ... }: {
  imports = [];


  options.bead.apps.blender = {
    enable = helpers.mkBooleanOption false "Whether to enable the Blender 3D modelling software";
    useHIP = helpers.mkBooleanOption true "Whether to use the Blender-HIP package, beneficial for AMD systems";
  };


  config = lib.mkIf (config.bead.apps.blender.enable) {
    home.packages = [
      (if (config.bead.apps.blender.useHIP) then pkgs.blender-hip else pkgs.blender)
    ];
  };
}
