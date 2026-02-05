{ config, pkgs, helpers, lib, ... }:

let
  inherit (lib) mkIf mkDefault;
  inherit (lib.lists) optionals;
  cfg = config.zen.system;

in {
  imports = helpers.getScopedSubmodules ../system "nixos";

  options.zen.system = {
    quietBoot = helpers.mkBooleanOption true "Whether to disable kernel systemd boot screen";
  };

  config = {
    # quiet boot
    boot.loader.timeout = mkIf (cfg.quietBoot) 0;
    boot.kernelParams = optionals (cfg.quietBoot) [ "quiet" "udev.log_level=3" ];
    boot.initrd.verbose = mkDefault (if cfg.quietBoot then false else true);
    boot.consoleLogLevel = mkDefault (if cfg.quietBoot then 0 else 4);

    # plymouth boot theme
    boot.plymouth = {
      enable = mkDefault true;
      theme = mkDefault "hexagon_hud";
      themePackages = mkDefault [
        (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "hexagon_hud" ]; })
      ];
    };
  };
}
