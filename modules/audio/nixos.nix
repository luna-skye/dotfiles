{ lib, pkgs, ... }:

{
  imports = [];
  options.zen.audio = {};
  config = {
    security.rtkit.enable = lib.mkDefault true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = lib.mkDefault true;

      alsa.enable       = lib.mkDefault true;
      alsa.support32Bit = lib.mkDefault true;

      pulse.enable = lib.mkDefault true;
      jack.enable  = lib.mkDefault true;
    };
    environment.systemPackages = [ pkgs.pulsemixer ];
  };
}
