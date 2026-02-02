{ osConfig, config }:

{
  position = "close_to_bar_button";
  diskPath = "/";
  cards = [
    { enabled = true; id = "profile-card"; }
    { enabled = true; id = "shortcuts-card"; }
    { enabled = true; id = "audio-card"; }
    { enabled = true; id = "brightness-card"; }
    { enabled = true; id = "weather-card"; }
    { enabled = true; id = "media-sysmon-card"; }
  ];
  shortcuts = {
    left = [
      { id = "Network"; }
      { id = "Bluetooth"; }
      { id = "WallpaperSelector"; }
      { id = "NoctaliaPerformance"; }
    ];
    right = [
      { id = "Notifications"; }
      { id = "PowerProfile"; }
      { id = "KeepAwake"; }
      { id = "NightLight"; }
    ];
  };
}
