{ osConfig, config }:

{
  autoHideDelay = 500;
  autoShowDelay = 150;
  backgroundOpacity = 0.95;
  position = "top";
  density = "default";
  barType = "framed";
  frameRadius = 12;
  frameThickness = 4;
  alwaysVisible = true;
  exclusive = true;
  floating = false;
  hideOnOverview = false;
  marginHorizontal = 4;
  marginVertical = 4;
  monitors = [];
  screenOverrides = [];
  outerCorners = true;

  capsuleOpacity = 1;
  showCapsule = false;
  showOutline = false;
  useSeparateOpacity = false;

  widgets = {
    left = [
      {
        id = "Launcher";
        icon = "moon";
        usePrimaryColor = true;
      }
      {
        id = "Workspace";
        labelMode = "index";
        labelScale = 0.8;
        showApplications = false;
        showBadge = true;
        showLabelsOnlyWhenOccupied = true;
        hideUnoccupied = false;
        followFocusedScreen = false;

        focusedColor = "primary";
        occupiedColor = "surfaceVariant";
        emptyColor = "surfaceVariant";

        enableScrollWheel = true;
        reverseScroll = false;
      }
      {
        id = "ActiveWindow";
        hideMode = "hidden";
        showIcon = true;
        colorizeIcons = false;

        maxWidth = 192;
        useFixedWidth = false;
        scrollingMode = "hover";
      }
    ];

    center = [
      {
        id = "Clock";
        formatHorizontal = "HH:mm | yyyy-MM-dd";
        tooltipFormat = "HH:mm ddd, MMM dd yyyy";
      }
      {
        id = "MediaMini";
        compactShowAlbumArt = true;
        hideMode = "hidden";
        hideWhenIdle = false;
        maxWidth = 192;
        useFixedWidth = false;
        scrollingMode = "always";

        showAlbumArt = true;
        showArtistFirst = true;
        showProgressRing = true;
        showVisualizer = true;
        visualizerType = "wave";
        panelShowAlbumArt = true;
        panelShowVisualizer = true;
      }
    ];

    right = [
      {
        id = "SystemMonitor";
        compactMode = true;
        showLoadAverage = false;
        showCpuUsage = true;
        showCpuFreq = false;
        showCpuTemp = true;
        showGpuTemp = true;
        showMemoryUsage = true;
        showMemoryAsPercent = true;
        showSwapUsage = true;
        showNetworkStats = true;
        showDiskUsage = true;
        diskPath = "/";
        useMonospaceFont = true;
        usePrimaryColor = false;
      }
      {
        id = "Tray";
        colorizeIcons = false;
        drawerEnabled = true;
        hidePassive = false;
        pinned = [];
        blacklist = [];
      }
      {
        id = "NotificationHistory";
        showUnreadBadge = true;
        unreadBadgeColor = "primary";
        hideWhenZero = false;
        hideWhenZeroUnread = false;
      }
      {
        id = "Volume";
        displayMode = "onhover";
        middleClickCommand = "pwvucontrol || pavucontrol";
      }
      {
        id = "ControlCenter";
        icon = "settings";
        useDistroLogo = true;
        enableColorization = true;
        colorizeDistroLogo = true;
        colorizeSystemIcon = "primary";
      }
    ];
  };
}
