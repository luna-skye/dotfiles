{ inputs, helpers, lib, config, ... }:


let
  cfg = config.zen.apps.teamspeak;
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    # this bad, fix soon at any cost
    config.permittedInsecurePackages = [ "qtwebengine-5.15.19" ]; 
  };

in {
  options.zen.apps.teamspeak = {
    enable = helpers.mkBooleanOption false "Whether to install the TeamSpeak 3 Client";
  };

  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = [ pkgs.teamspeak3 ];
  };
}
