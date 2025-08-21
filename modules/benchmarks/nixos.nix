{ config, helpers, pkgs, lib, ... }:


let
  cfg = config.zen.benchmarks;

in {
  options.zen.benchmarks = {
    enable = helpers.mkBooleanOption false "Whether to install benchmarking utility softwares";
    unigine.enable = helpers.mkBooleanOption true "Whether to install Unigine Engine 3D benchmarks";
  };

  config = lib.mkIf (cfg.enable) {
    environment.systemPackages =
      builtins.attrValues { inherit (pkgs)
        lm_sensors           # read chip sensors
        phoronix-test-suite  # variety of tests across cpu, mem, gpu, io, and network
        iozone               # io (disk) tests
        vkmark               # vulkan tests
        furmark              # opengl/vulkan tests
        ;
      } ++
      lib.lists.optionals (cfg.unigine.enable) builtins.attrValues { inherit (pkgs)
        unigine-valley
        unigine-tropics
        unigine-superposition
        unigine-sanctuary
        unigine-heaven
        ;
      };
  };
}
