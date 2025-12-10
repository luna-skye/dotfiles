{ config, pkgs, lib, inputs, ... }:


let
  stellae = inputs.stellae-nix.lib;
  cfg = config.zen.theme;

  mkFontOption = default: desc: lib.mkOption {
    description = desc;
    type = lib.types.submodule {
      options = {
        name = lib.mkOption {
          description = "Name of the font within the package to use";
          type = lib.types.str;
        };

        package = lib.mkOption {
          description = "Package providing the font";
          type = lib.types.package;
        };
      };
    };
    default = default;
  };

in {
  options.zen.theme = {
    enable = lib.mkEnableOption "Enable custom color palettes";
    element = lib.mkOption {
      description = "STELLAE element to use as a color scheme across all applications";
      type = lib.types.attrs;
      default = stellae.elements.hydrogen;
    };

    fonts = {
      enable = lib.mkEnableOption "Enable automatic management of fonts";
      monospace = mkFontOption { name = "JetBrains Mono";   package = pkgs.jetbrains-mono;   } "Monospace font to apply to target apps";
      sans      = mkFontOption { name = "Noto Sans";        package = pkgs.noto-fonts;       } "Sans font to apply to target apps";
      serif     = mkFontOption { name = "Noto Serif";       package = pkgs.noto-fonts;       } "Serif font to apply to target apps";
      emoji     = mkFontOption { name = "Noto Color Emoji"; package = pkgs.noto-fonts-emoji; } "Emoji font to apply to target apps";
    };

    palette = lib.mkOption {
      type = lib.types.attrs;
      default = stellae.colors.convertElementTokens cfg.element;
      description = "Palette, converted from a STELLAE element, used in software theme configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.fonts.monospace.package
      cfg.fonts.sans.package
      cfg.fonts.serif.package
      cfg.fonts.emoji.package
    ];
  };
}
