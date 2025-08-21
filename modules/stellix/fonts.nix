{ config, lib, pkgs, ... }:

let
  cfg = config.theme.fonts;
  mkFontOption = default: desc: lib.mkOption {
    description = desc;
    type = lib.types.submodule {
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
    default = default;
  };

in {
  options.theme.fonts = {
    enable = lib.mkEnableOption "Enable the automatic declaration of fonts throughout the system";
    monospace = mkFontOption { name = "JetBrains Mono";   package = pkgs.jetbrains-mono;   } "Monospace font to apply to target apps";
    sans      = mkFontOption { name = "Noto Sans";        package = pkgs.noto-fonts;       } "Sans font to apply to target apps";
    serif     = mkFontOption { name = "Noto Serif";       package = pkgs.noto-fonts;       } "Serif font to apply to target apps";
    emoji     = mkFontOption { name = "Noto Color Emoji"; package = pkgs.noto-fonts-emoji; } "Emoji font to apply to target apps";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.monospace.package
      cfg.sans.package
      cfg.serif.package
      cfg.emoji.package
    ];
  };
}
