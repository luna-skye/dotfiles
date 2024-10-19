{ config, lib, bead, ... }: {
  imports = [];


  options.bead.networking = {
    ssh.enable = bead.mkBooleanOption true "Whether to allow SSH connections made to this NixOS system";
  };


  config = {
    services.openssh = lib.mkIf (config.bead.networking.ssh.enable) {
      enable = true;
      ports = [ 22 ];

      settings = {
        AllowUsers = bead.usersWithEnabled [ "bead" "cli" "networking" "ssh" "enable" ] config;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };
  };
}
