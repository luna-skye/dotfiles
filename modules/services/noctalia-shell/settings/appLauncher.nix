{ osConfig, config }:

{
  position = "top_center";
  showCategories = true;
  showIconBackground = false;
  sortByMostUsed = true;
  viewMode = "list";

  terminalCommand = "kitty -e";
  screenshotAnnotationTool = "";
  useApp2Unit = false;

  autoPasteClipboard = false;
  clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
  clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
  clipboardWrapText = true;
  enableClipPreview = true;
  enableClipboardHistory = true;
  enableSettingsSearch = true;
  enableWindowsSearch = true;
  
  iconMode = "tabler";
  ignoreMouseInput = false;
  pinnedApps = [];

  customLaunchPrefexEnabled = false;
  customLaunchPrefex = "";
}
