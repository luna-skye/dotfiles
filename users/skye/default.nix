{ lib, ... }:

{
  imports = [
    ./packages.nix
    ./xdg.nix
  ];

  zen = {
    networking.allowSSH = true;
    cli.git = {
      username = "Luna Skye";
      email = "sepshuncontact@gmail.com";
    };

    session.hyprland.keybinds.actions.openBrowser = "zen-twilight";

    apps.default = {
      browser = [ "zen.desktop" ];
    };

    theme = {
      enable = true;
      fonts.enable = true;
    };
  };

  home.username = "skye";
  home.homeDirectory = lib.mkForce "/home/skye";
}
