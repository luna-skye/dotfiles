{ lib, ... }:

{
  zen = {
    cli.git = {
      username = "%name%";
      email = "%name%@replace.me";
    };
    networking.allowSSH = false;
  };

  home.username = "%name%";
  home.homeDirectory = lib.mkForce "/home/%name%";
}
