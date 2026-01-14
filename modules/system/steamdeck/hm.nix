{ osConfig, config, lib, ... }:

let
  # inherit (lib) mkDefault;
  # cfg = config.zen.system.steamdeck;
  # hostCfg = osConfig.zen.system.steamdeck;

in {
  # config = lib.mkIf (hostCfg.enable) {
  #   zen.session.niri.keybinds.keys = {
  #     mod = mkDefault "";
  #     open-overview = mkDefault "";
  #     hotkey-overlay = mkDefault "";
  #     application-launcher = mkDefault "";
  #     config-menu = mkDefault "";
  #   };
  # };
}
