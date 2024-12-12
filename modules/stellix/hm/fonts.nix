{ config, lib, bead, pkgs, ... }: let
  # Represents a font type with an name and package options
  fontType = lib.types.submodule {
    options = {
      name = lib.mkOption {
        description = lib.mdDoc "Name of the font within the package to use";
        type = lib.types.str;
      };

      package = lib.mkOption {
        description = lib.mdDoc "Package providing the font";
        type = lib.types.package;
      };
    };
  };
in {
  imports = [];


  options.bead.stellix.fonts = {
    enable = bead.mkBooleanOption true "Whether to enable STELLIX controlled fonts";

    monospace = lib.mkOption {
      description = "Monospace font to be applied across targetted apps";
      type = fontType;
      default = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
    };

    sans = lib.mkOption {
      description = "Sans serif font to be applied across targetted apps";
      type = fontType;
      default = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
    };

    serif = lib.mkOption {
      description = "Serif font to be used across targetted apps";
      type = fontType;
      default = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
    };

    emoji = lib.mkOption {
      description = "Emoji font to be used across targetted apps";
      type = fontType;
      default = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
    };
  };


  config = lib.mkIf (config.bead.stellix.enable && config.bead.stellix.fonts.enable) {
    home.packages = [
      config.bead.stellix.fonts.monospace.package
      config.bead.stellix.fonts.sans.package
      config.bead.stellix.fonts.serif.package
      config.bead.stellix.fonts.emoji.package
    ];
  };
}
