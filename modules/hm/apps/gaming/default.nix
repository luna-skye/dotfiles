{ config, lib, bead, pkgs, ... }: {
  imports = [];


  options.bead.apps.gaming = {
    enable = bead.mkBooleanOption false "Whether to enable ANY gaming related packages";

    steam = {
      enable = bead.mkBooleanOption true "Whether to enable the Steam gaming platform";
    };

    heroic = {
      enable = bead.mkBooleanOption true "Whether to enable the Heroic gaming platform, for Epic Games content";
    };

    lutris = {
      enable = bead.mkBooleanOption true "Whether to enable the Lutris gaming application";
    };

    minecraft = {
      modrinth = {
        enable = bead.mkBooleanOption true "Whether to enable the Modrinth Minecraft launcher";
      };

      atl = {
        enable = bead.mkBooleanOption false "Whether to enable the ATLauncher Minecraft launcher";
      };

      prism = {
        enable = bead.mkBooleanOption false "Whether to enable the Prism Launcher";
      };
    };
  };


  config = lib.mkIf (config.bead.apps.gaming.enable) {
    home.packages = [] ++
      (lib.lists.optional (config.bead.apps.gaming.steam.enable) pkgs.protontricks) ++
      (lib.lists.optional (config.bead.apps.gaming.lutris.enable) pkgs.lutris) ++

      (lib.lists.optional (config.bead.apps.gaming.minecraft.atl.enable) pkgs.atlauncher) ++
      (lib.lists.optional (config.bead.apps.gaming.minecraft.modrinth.enable) pkgs.prismlauncher) ++
      (lib.lists.optional (config.bead.apps.gaming.minecraft.prism.enable) pkgs.modrinth-app);
  };
}
