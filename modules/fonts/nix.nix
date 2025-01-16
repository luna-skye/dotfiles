#  TODO: User level font configuration? Maybe hm has some option

{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.fonts;
in {
  imports = [];


  options.bead.fonts = {
    enableDefault = helpers.mkBooleanOption true "Whether to install the default fonts bundled with the config";
    extraFonts = helpers.mkListOfOption lib.types.package [] "Extra font packages to install into the system";
  };
  

  config = let
    defaultFonts = builtins.attrValues { inherit (pkgs) 
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      fira-code
      fira-code-symbols
      jetbrains-mono
      nerdfonts
      ; 
    };
  in {
    fonts.packages = cfg.extraFonts ++
                     lib.lists.optionals (cfg.enableDefault) defaultFonts;
  };
}
