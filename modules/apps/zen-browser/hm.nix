{ inputs, osConfig, lib, ... }:

let
  inherit (lib) mkDefault;
  hostCfg = osConfig.zen.apps.zen-browser;

in {
  imports = [ inputs.zen-browser.homeModules.twilight ];
  config = lib.mkIf (hostCfg.enable) {
    programs.zen-browser = {
      enable = mkDefault true;
      policies = {
        DisableAppUpdate = mkDefault true;
        DisableTelemetry = mkDefault hostCfg.disableTelemetry;
        DisableFeedbackCommands = mkDefault true;
        DisableFirefoxStudies = mkDefault true;
        DisablePocket = mkDefault true;
        DontCheckDefaultBrowser = mkDefault true;
        NoDefaultBookmarks = mkDefault true;

        OfferToSaveLogins = mkDefault false;
        AutofillAddressEnabled = mkDefault true;
        AutofillCreditCardEnabled = mkDefault false;
      };
    };
  };
}
