{ osConfig, lib, pkgs, ... }:

let
  hostCfg = osConfig.zen.apps.gaming;
  inherit (lib.lists) optional;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages =
      optional (hostCfg.steam.enable)              pkgs.protontricks  ++
      optional (hostCfg.lutris.enable)             pkgs.lutris        ++
      optional (hostCfg.r2modman.enable)           pkgs.r2modman      ++

      optional (hostCfg.minecraft.atl.enable)      pkgs.atlauncher    ++
      optional (hostCfg.minecraft.prism.enable)    pkgs.prismlauncher ++
      optional (hostCfg.minecraft.modrinth.enable) pkgs.modrinth-app  ++
      builtins.attrValues { inherit (pkgs) 
        gamescope
        vulkan-tools
        libdrm
        ;
      } ++ [ pkgs.xorg.xrandr ];
  };
}
