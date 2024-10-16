{ inputs, options, config, lib, ... }: {
  imports = [];


  options.bead.apps.browser.floorp = {
    enable = lib.mkOption {
      description = "Whether to enable the Floorp web browser";
      type = lib.types.bool;
      default = false;
    };

    enableDefaultExtensions = lib.mkOption {
      description = "Whether to enable the preconfigured extensions for Floorp";
      type = lib.types.bool;
      default = true;
    };

    settings = {
      openPrevious = {};
      verticalTabs = {};
      
    };
  };


  config = lib.mkIf (config.bead.apps.browser.floorp.enable) {
  };
}
