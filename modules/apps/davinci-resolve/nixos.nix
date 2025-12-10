{ config, helpers, pkgs, lib, ... }:


let
  cfg = config.zen.apps.davinci-resolve;

in {
  options.zen.apps.davinci-resolve = {
    enable = helpers.mkBooleanOption false "Whether to install the Davinci Resolve video editing software";
  };

  config = lib.mkIf (cfg.enable) {
    environment.variables.RUSTICLE_ENABLE = "radeonsi";
    hardware.graphics.extraPackages = [
      pkgs.mesa.opencl
      pkgs.rocmPackages.clr.icd
    ];
  };
}
