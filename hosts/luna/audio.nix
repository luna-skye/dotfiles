{ ... }: {
  musnix.enable = true;
  services.pipewire.extraConfig.pipewire-pulse = {
    "context.modules" = [{
      name = "alsa-card";
      args = {
        card.profile = "pro-audio";
        card.name = "alsa_card.usb-Native_Instruments_Komplete_Audio_6_348D12EB-00";
        card.nick = "Komplete Audio 6";
      };
    }];
  };
}
