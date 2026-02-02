{ osConfig, config }:

{
  enabled = true;
  location = "top_right";
  backgroundOpacity = 1;
  overlayLayer = true;

  lowUrgencyDuration = 3;
  normalUrgencyDuration = 8;
  criticalUrgencyDuration = 15;
  respectExpireTimeout = false;
  saveToHistory = {
    low = true;
    normal = true;
    critical = true;
  };

  enableKeyboardLayoutToast = true;
  enableMediaToast = false;

  monitors = [];
  sounds = {
    enabled = false;
    volume = 0.5;
    excludedApps = "discord,firefox,chrome,chromium,edge";

    lowSoundFile = "";
    normalSoundFile = "";
    criticalSoundFile = "";
    separateSounds = false;
  };
}
