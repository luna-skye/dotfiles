{ config, helpers, pkgs, lib, ... }:


let
  cfg = config.zen.printing;

in {
  options.zen.printing = {
    enable = helpers.mkBooleanOption false "Whether to enable printing services";
    extraDrivers = helpers.mkListOfOption lib.types.package [] "Extra device drivers to install";
    networking.enable = helpers.mkBooleanOption true "Whether to enable network based printing for this system's printers";
  };

  config = lib.mkIf (cfg.enable) {
    services.printing = {
      enable = true;
      allowFrom = lib.lists.optionals (cfg.networking.enable) [ "all" ];
      browsing = cfg.networking.enable;
      defaultShared = cfg.networking.enable;
      openFirewall = cfg.networking.enable;
      drivers = cfg.extraDrivers;
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = lib.mkIf (cfg.networking.enable) {
        enable = true;
        userServices = true;
      };
    };
  };
}
