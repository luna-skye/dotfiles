{ config, lib, bead, ... }: {
  imports = [];


  options.bead.ssh = {
    enable = bead.mkBooleanOption true "Whether to allow SSH connections made to this NixOS system";
  };


  config = lib.mkIf (config.bead.ssh.enable) {
    services.openssh = {
      enable = true;
      ports = [ 22 ];

      settings = {
        AllowUsers = bead.usersWithEnabled [ "bead" "cli" "ssh" "enable" ] config;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };
  };
}
