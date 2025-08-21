{ config, lib, helpers, ... }:

let
  inherit (lib) mkDefault;
  cfg = config.zen.networking;

in {
  imports = [];

  options.zen.networking = {
    ssh.enable = helpers.mkBooleanOption true "Whether to allow SSH connections made to this NixOS system";
  };

  config = {
    networking = {
      networkmanager = {
        enable = mkDefault true;
      };
      firewall = {
        enable = mkDefault true;
        allowPing = mkDefault false;
        allowedTCPPorts = [];
        allowedUDPPorts = [];
      };
    };

    services.openssh = lib.mkIf (cfg.ssh.enable) {
      enable = mkDefault true;
      ports = mkDefault [ 22 ];

      settings = {
        AllowUsers = helpers.usersWithEnabled [ "zen" "networking" "allowSSH" ] config;
        UseDns = mkDefault true;
        X11Forwarding = mkDefault false;
        PermitRootLogin = mkDefault "prohibit-password";
      };
    };

    systemd.services.NetworkManager-wait-online.enable = mkDefault false;
  };
}
