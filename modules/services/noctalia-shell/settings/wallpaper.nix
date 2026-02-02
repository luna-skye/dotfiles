{ osConfig, config }:

{
  enabled = true;
  overviewEnabled = false;
  panelPosition = "follow_bar";

  directory = "/home/${config.home.username}/Pictures/converted";
  hideWallpaperFilenames = false;
  showHiddenFiles = false;

  enableMultiMonitorDirectories = false;
  setWallpaperOnAllMonitors = true;

  automationEnabled = true;
  randomIntervalSec = 3600;
  transitionType = "random";
  transitionDuration = 1500;
  transitionEdgeSmoothness = 0.05;

  useSolidColor = false;
  solidColor = "#1a1a2e";
  fillMode = "crop";
  fillColor = "#000000";

  useWallhaven = false;
}
