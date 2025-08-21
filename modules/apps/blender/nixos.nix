{ config, lib, pkgs, helpers, ... }:

let
  cfg = config.zen.apps.blender;
in {
  options.zen.apps.blender = {
    enable = helpers.mkBooleanOption false "Whether to enable the Blender3D modeling software";
    useHIP = helpers.mkBooleanOption true "Whether to configure Blender for AMD GPUs through the HIP driver";
  };

  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = 
      lib.lists.optional (cfg.useHIP) pkgs.blender-hip ++
      lib.lists.optional (!cfg.useHIP) pkgs.blender;

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
