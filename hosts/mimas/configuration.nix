{ ... }:

{
  zen = {
    host.name = "mimas";
    session = {
      default = "plasma";
      plasma.enable = true;
      niri.enable = true;

      monitors = [{
        name        = "eDP-1";
        resolution  = "1920x1080";
        offset      = "0x0";
        refreshRate = 60;
        workspaces  = [ 1 2 3 4 5 ];
      }];
    };
    services = {
      dunst.enable = true;
      tofi.enable = true;
      swww.enable = true;
      dms.enable = true;
    };
    apps = {
      zen-browser.enable = true;
      obsidian.enable = true;
      gaming.enable = true;
      discord.enable = true;
      signal.enable = true;
      anki.enable = true;
      komikku.enable = true;
      feishin.enable = true;
    };
  };
  services.upower.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.skye = {
    isNormalUser = true;
    description = "skye";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "skye";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
