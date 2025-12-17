{ config, lib, helpers, ... }:


let
  inherit (lib) mkDefault;
  cfg = config.zen.services.dms;

in {
  options.zen.services.dms = {
    enable = helpers.mkBooleanOption false "Whether to install the Dank Material Shell";
  };

  config = lib.mkIf (cfg.enable) {
    programs.dms-shell = {
      enable = mkDefault true;

      systemd = {
        enable = mkDefault true;
        restartIfChanged = mkDefault true;
      };

      enableSystemMonitoring = mkDefault true;
      enableClipboard = mkDefault true;
      enableVPN = mkDefault true;
      enableAudioWavelength = mkDefault true;
      enableCalendarEvents = mkDefault true;
    };
  };
}
