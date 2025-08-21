{ config, helpers, lib, inputs, ... }:

let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    config.permittedInsecurePackages = [ "openssl-1.1.1w" ]; 
  };
in {
  options.zen.apps.unityhub = {
    enable = helpers.mkBooleanOption false "Whether to install the Unity Engine Hub";
  };
  config = lib.mkIf (config.zen.apps.unityhub.enable) {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
    environment.systemPackages = [
      (pkgs.unityhub.override {
        extraPkgs = fhsPkgs: [
          fhsPkgs.harfbuzz
          fhsPkgs.libogg
        ];
        extraLibs = fhsPkgs: [
          fhsPkgs.openssl_1_1
        ];
      })
    ];
  };
}
