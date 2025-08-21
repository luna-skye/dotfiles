{ config, lib, helpers, ... }:

{
  options.zen.apps.kdeconnect = {
    enable = helpers.mkBooleanOption true "Whether to install the KDE Connect application";
  };
  config = lib.mkIf (config.zen.apps.kdeconnect.enable) {
    networking.firewall.allowedTCPPorts = [ 1716 ];
    networking.firewall.allowedUDPPorts = [ 1716 ];
  };
}
