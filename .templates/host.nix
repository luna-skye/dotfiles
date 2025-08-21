{ ... }:

{
  zen = {
    host.name = "%name%";
    session = {
      default = "plasma";
      plasma.enable = true;
    };
    apps = {};
  };

  # TODO: Replace USERNAME with your primary user's username
  users.users."USERNAME" = {
    isNormalUser = true;
    description = "USERNAME";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "USERNAME";
}
