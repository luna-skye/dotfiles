{ config, pkgs, lib, helpers, ... }:

let 
  cfg = config.zen.apps.piper;

in {
  options.zen.apps.piper = {
    enable = helpers.mkBooleanOption false "Whether to enable the Piper mouse control application";
  };

  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = [
      pkgs.libratbag
      pkgs.piper
    ];

    # create libratbag service so the daemon runs on startup
    systemd.services.libratbag = {
      description = "libratbag mouse daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.libratbag}/bin/libratbag";
        Restart = "always";
        User = "root";
      };
    };
  };
}
