{ osConfig, config, pkgs, lib, stellae, ... }:


let
  hostCfg = osConfig.zen.services.dms;
  cfg = config.zen.services.dms;

  theme = stellae.exporters.dms-shell.plaintext { element = config.zen.theme.element; };
  themeFile = pkgs.writeText "stellae-dms" theme;

in {
  imports = [];

  options.zen.services.dms = {};

  config = lib.mkIf (hostCfg.enable) {
    home.file.".config/totality-nixos/stellae-dms-theme.json".text = theme;

    # declarative DMS config, may cause read-only issues
    # disabled until can put more time into it
    # home.file.".config/DankMaterialShell/settings.json".text = builtins.toJSON {
    #   currentThemeName = "custom";
    #   customThemeFile = themeFile;
    #   mutagenScheme = "scheme-tonal-spot";
    #   runUserMatugenTemplates = true;
    # };
  };
}
