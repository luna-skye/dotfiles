#  TODO: Look into improving this, either with custom config or from Musnix
{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.audio;
in {
  imports = [];


  options.bead.audio = {};
  

  config = {
    hardware.pulseaudio.enable = lib.mkDefault false;

    security.rtkit.enable = lib.mkDefault true;
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
