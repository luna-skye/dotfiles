{ osConfig, pkgs, lib, ... }:


let
  hostCfg = osConfig.zen.system.fan2go;
  fan2go-tui = pkgs.buildGoModule rec {
    pname = "fan2go-tui";
    version = "0.2.1";
    src = pkgs.fetchFromGitHub {
      owner = "markusressel";
      repo = "fan2go-tui";
      tag = version;
      hash = "sha256-15UyuDwVyKNPgF+C/ApjQDqWMQoeO2C1aLRniC6xJFY=";
      leaveDotGit = true;
    };
    vendorHash = "sha256-IMMnZZ6oJMRxtfT9iFM7pbAauvglt74i4Nco/rMwX/g=";
    meta = {
      description = "TUI application for fan2go";
      mainProgram = "fan2go-tui";
      homepage = "https://github.com/markusressel/fan2go-tui";
      license = lib.licenses.agpl3Plus;
      platforms = lib.platforms.linux;
    };
  };

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages = [
      pkgs.fan2go
      fan2go-tui
    ];
  };
}
