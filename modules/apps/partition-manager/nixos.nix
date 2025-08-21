{ config, lib, helpers, ... }:

let
  cfg = config.zen.apps.partition-manager;
in {
  imports = [];
  options.zen.apps.partition-manager = {
    enable = helpers.mkBooleanOption true "Whether to install the KDE Partition Manager application";
  };
  config = lib.mkIf (cfg.enable) {
    programs.partition-manager.enable = true;
  };
}
