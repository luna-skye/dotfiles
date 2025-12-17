{ lib, pkgs, ... }:


let
  inherit (lib) mkDefault;

in {
  options.zen.audio = {};

  config = {
    security.rtkit.enable = mkDefault true;

    services = {
      irqbalance.enable = mkDefault true;
      pulseaudio.enable = mkDefault false;
      pipewire = {
        enable = mkDefault true;
        alsa.enable       = mkDefault true;
        alsa.support32Bit = mkDefault true;
        pulse.enable      = mkDefault true;
        jack.enable       = mkDefault true;
      };
    };

    environment.systemPackages = [ pkgs.pulsemixer ];
  };
}
