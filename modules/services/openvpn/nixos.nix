{ config, helpers, ... }:

let
  cfg = config.zen.services.openvpn;

in {
  imports = [];
  options.zen.services.openvpn = {
    autoStart = helpers.mkBooleanOption false "Whether to automatically start the OpenVPN service";
    region = helpers.mkStringOption "USA - Chicago" "VPN region to attempt connecting to";
  };
  config = {
    services.openvpn.servers.vpn = {
      autoStart = cfg.autoStart;
      config = ''
        config "/var/lib/secrets/vpn/vypr/256/${cfg.region}.ovpn"
        auth-user-pass "/var/lib/secrets/vpn/vypr/auth"
      '';
    };
  };
}

