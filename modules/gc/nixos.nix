{ config, lib, helpers, ... }:

let
  cfg = config.zen.gc;

in {
  imports = [];

  options.zen.gc = {
    enableAuto = helpers.mkBooleanOption true "Whether to enable automatic garbage collection Nix store";
    autoFrequency = helpers.mkStringOption "weekly" "How frequently to run automatic garbage collection";
    autoDeleteAfter = helpers.mkStringOption "1w" "Timeframe to keep generations around for";
  };

  config = {
    nix.gc = lib.mkIf (cfg.enableAuto) {
      automatic = lib.mkDefault true;
      dates     = lib.mkDefault cfg.autoFrequency;
      options   = lib.mkDefault "--delete-older-than ${cfg.autoDeleteAfter}";
    };
  };
}
