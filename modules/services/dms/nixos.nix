{ config, lib, helpers, ... }:


let
  cfg = config.zen.services.dms;

in {
  options.zen.services.dms = {
    enable = helpers.mkBooleanOption false "Whether to install the Dank Material Shell";
  };

  config = lib.mkIf (cfg.enable) {
    programs.dms-shell = {
      enable = true;

      enableSystemMonitoring = true;
      enableClipboard = true;
      enableVPN = true;
      enableDynamicTheming = false;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };
  };
}
