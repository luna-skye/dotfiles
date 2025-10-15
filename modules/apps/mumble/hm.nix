{ osConfig, lib, pkgs, ... }:


let
  cfg = osConfig.zen.apps.mumble;

in {
  config = lib.mkIf (cfg.enable) {
    home.packages = [ pkgs.mumble ];
  };
}
