{ osConfig, config, lib, ... }:


let
  hostCfg = osConfig.zen.services.dms;
  cfg = config.zen.services.dms;

in {
  imports = [];

  options.zen.services.dms = {};

  config = lib.mkIf (hostCfg.enable) {

  };
}
