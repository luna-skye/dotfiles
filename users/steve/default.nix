{ pkgs, lib, ... }:

{
  home.username = "steve";
  home.homeDirectory = lib.mkForce "/home/steve";

  zen.networking.allowSSH = true;
  zen.cli.git = {
    username = "slic1976";
    email = "slic1976@gmail.com";
  };

  home.packages = builtins.attrValues {
    inherit (pkgs.kdePackages) kate kcalc;
    inherit (pkgs) usbimager;
  };
  programs.firefox.enable = true;
}
