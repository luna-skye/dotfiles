{ lib, ... }:

{
  zen = {
    cli.git = {
      username = "Seajewel";
      email = "seajewel33@gmail.com";
    };
    networking.allowSSH = true;
  };

  home.username = "seajewel";
  home.homeDirectory = lib.mkForce "/home/seajewel";
}
