{ lib, ... }:

{
  imports = [
    ./packages.nix
    ./xdg.nix
  ];

  zen = {
    cli.git = {
      username = "Luna Skye";
      email = "sepshuncontact@gmail.com";
    };
    networking.allowSSH = true;
    session.hyprland.keybinds.actions.openBrowser = "zen";
    apps.default = {
      browser = [ "zen.desktop" ];
    };
  };

  theme = {
    enable = true;
    fonts.enable = true;
    target = {
      hyprland.enable = true;
      dunst.enable = true;
      kitty.enable = true;
    };
  };

  home.username = "skye";
  home.homeDirectory = lib.mkForce "/home/skye";
}
