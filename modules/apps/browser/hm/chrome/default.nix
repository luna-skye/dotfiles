{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.apps.browser.chrome;
in {
  imports = [];


  options.bead.apps.browser.chrome = {
    enable = bead.mkBooleanOption false "Whether to enable the Chromium browser";

    pkg = lib.mkOption {
      description = "The package to install for the Chromium browser, ungoogled by default";
      type = lib.types.package;
      default = pkgs.ungoogled-chromium;
    };
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = [ cfg.pkg ];
  };
}
