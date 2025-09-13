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
      hash = "sha256-ML6ZdXfD+s7NqZ6xZfOjS6Oj4lBwk3HgVayfCApvK3g=";
      leaveDotGit = true;
    };
    vendorHash = "sha256-vkfeEjQh+i/YPRwe9aotMU+wHTOXFDLpIKbPixuURt8=";
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
