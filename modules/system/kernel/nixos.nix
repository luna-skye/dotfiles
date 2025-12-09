{ config, inputs, pkgs, lib, helpers, ... }:


let
  cfg = config.zen.system.kernel;

in {
  options.zen.system.kernel = {
    useCachy = helpers.mkBooleanOption false "Whether to use the CachyOS kernel";
  };

  config = {
    boot.kernelPackages = lib.mkIf (cfg.useCachy)
      inputs.nix-cachyos-kernel.legacyPackages.${pkgs.system}.linuxPackages-cachyos-latest;
  };
}
