{ config, lib, helpers, ... }: {
  imports = [];


  options.bead.networking = {
    ssh.enable = helpers.mkBooleanOption true "Whether to allow SSH connections made to this NixOS system";
  };


  config = {
    networking = {
      networkmanager = {
        enable = lib.mkDefault true;
      };
      firewall = {
        enable = lib.mkDefault true;
        allowPing = lib.mkDefault false;
        allowedTCPPorts = [];
        allowedUDPPorts = [];
      };
    };

    services.openssh = lib.mkIf (config.bead.networking.ssh.enable) {
      enable = true;
      ports = [ 22 ];

      settings = {
        AllowUsers = helpers.usersWithEnabled [ "bead" "networking" "ssh" "enable" ] config;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };

    systemd.services.NetworkManager-wait-online.enable = lib.mkDefault false;
  };
}
