{ config, lib, helpers, pkgs, ... }:

let
  cfg = config.zen.fonts;

in {
  imports = [];

  options.zen.fonts = {
    enableDefault = helpers.mkBooleanOption true "Whether to install the default fonts bundled with the config";
    extraFonts = helpers.mkListOfOption lib.types.package [] "Extra font packages to install into the system";
  };
  
  config = let
    nerdfonts = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    defaultFonts = builtins.attrValues { inherit (pkgs) 
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      fira-code
      fira-code-symbols
      jetbrains-mono
      ; 
    } ++ nerdfonts;
  in {
    fonts.packages = cfg.extraFonts ++ lib.lists.optionals (cfg.enableDefault) defaultFonts;
  };
}
