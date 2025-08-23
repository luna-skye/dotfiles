{ ... }:

{
  zen = {
    host.name = "ariel";
    session = {
      default = "plasma";
      plasma.enable = true;
    };
    apps = {
      zen-browser.enable = true;
      obsidian.enable = true;
      rgb.enable = true;
      office.enable = true;
      gaming = {
        enable = true;
        lutris.enable = true;
        minecraft.prism.enable = true;
      };
      media = {
        image.gwenview.enable = true;
        video.vlc.enable = true;
        audio.elisa.enable = true;
      };
      feishin.enable = true;
      bottles.enable = true;
      discord.enable = true;
      signal.enable = true;
    };
    printing.enable = true;
  };

  users.users.seajewel = {
    isNormalUser = true;
    description = "seajewel";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "seajewel";
  services.xserver.videoDrivers = [ "amdgpu" ];
}
