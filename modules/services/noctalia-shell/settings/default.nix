{ osConfig, config }:

{
  general = {
    language = "";
    avatarImage = "/home/${config.home.username}/.face";

    dimmerOpacity = 0.2;
    animationDisabled = false;
    animationSpeed = 1;

    allowPanelsOnScreenWithoutBar = true;
    allowPasswordWithFprintd = false;
    autoStartAuth = false;
    boxRadiusRatio = 1;
    compactLockScreen = false;
    dimmerOpacty = 0.2;
    forceBlackScreenCorners = false;
    iRadiusRatio = 1;
    radiusRatio = 1;
    scaleRatio = 1;
    screenRadiusRatio = 1;
    showScreenCorners = true;

    enableShadows = false;
    shadowDirection = "bottom_right";
    shadowOffsetX = 2;
    shadowOffsetY = 2;

    lockOnSuspend = true;
    enableLockScreenCountdown = true;
    lockScreenCountdownDuration = 10000;
    showHibernateOnLockScreen = false;
    showSessionButtonsOnLockScreen = true;

    showChangelogOnStartup = true;
    telemetryEnabled = false;
  };

  appLauncher   = import ./appLauncher.nix   { inherit osConfig config; };
  audio         = import ./audio.nix         { inherit osConfig config; };
  bar           = import ./bar.nix           { inherit osConfig config; };
  calendar      = import ./calendar.nix      { inherit osConfig config; };
  controlCenter = import ./controlCenter.nix { inherit osConfig config; };
  dock          = import ./dock.nix          { inherit osConfig config; };
  network       = import ./network.nix       { inherit osConfig config; };
  notifications = import ./notifications.nix { inherit osConfig config; };
  osd           = import ./osd.nix           { inherit osConfig config; };
  sessionMenu   = import ./sessionMenu.nix   { inherit osConfig config; };
  ui            = import ./ui.nix            { inherit osConfig config; };
  wallpaper     = import ./wallpaper.nix     { inherit osConfig config; };
}
