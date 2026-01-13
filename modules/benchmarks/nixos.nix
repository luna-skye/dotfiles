{ config, helpers, pkgs, lib, ... }:


let
  cfg = config.zen.benchmarks;

  unigineBenchmarks = builtins.attrValues { inherit (pkgs)
    unigine-valley
    unigine-superposition
    unigine-heaven
    ;
  };

in {
  options.zen.benchmarks = {
    enable = helpers.mkBooleanOption false "Whether to install benchmarking utility softwares";

    # causing hash mismatch failures in 25.11
    # see: https://github.com/NixOS/nixpkgs/issues/469329
    unigine.enable = helpers.mkBooleanOption false "Whether to install Unigine Engine 3D benchmarks";
  };

  config = lib.mkIf (cfg.enable) {
    environment.systemPackages =
      builtins.attrValues { inherit (pkgs)
        lm_sensors           # read chip sensors
        geekbench            # general cpu/gpu benches
        phoronix-test-suite  # variety of tests across cpu, mem, gpu, io, and network
        iozone               # io (disk) tests
        # vkmark               # vulkan tests (disabled due to failed builds 2026-01-13)
        furmark              # opengl/vulkan tests
        ;
      } ++
      lib.lists.optionals (cfg.unigine.enable) unigineBenchmarks;
  };
}
