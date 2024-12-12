{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.apps.browser.floorp;
in {
  imports = [];


  options.bead.apps.browser.floorp = {
    enable = bead.mkBooleanOption false "Whether to enable the Floorp web browser";
    # enableDefaultExtensions = bead.mkBooleanOption true "Whether to enable the preconfigured extensions for Floorp";

    # settings = {
    #   openPrevious = {};
    #   verticalTabs = {};
    # };
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.floorp ];

    #  NOTE: this overrides global prefs and might not be ideal, look into it

    # home.file.".floorp/prefs.js".text = let
    #   floorpPrefs = {
    #     "browser.startup.homepage" = "https://start.duckduckgo.com/";
    #     "extensions.activeThemeID" = "default-theme@mozilla.org";
    #   };
    # in ''
    #   ${pkgs.lib.concatMapStringsSep "\n" (pref:
    #     "user_pref(\"${pref}\", ${toString floorpPrefs.${pref}});"
    #   ) (builtins.attrNames floorpPrefs)}
    # '';
    # home.file.".floorp/extensions".source = ../todo;
    # home.file.".floorp/chrome/userChrome.css".text = '''';
  };
}
