{ config, lib, pkgs, ... }: {
  imports = [];


  options.bead.apps.browser.chrome = {
    enable = lib.mkOption {
      description = "Whether to enable the Chrome browser";
      type = lib.types.bool;
      default = false;
    };

    package = lib.mkOption {
      description = "The package to install for the Chromium browser";
      type = lib.types.package;
      default = pkgs.ungoogled-chromium;
    };
  };


  config = lib.mkIf (config.bead.apps.browser.chrome.enable) {

  };
}
