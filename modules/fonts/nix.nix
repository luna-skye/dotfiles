#  TODO: User level font configuration? Maybe hm has some option

{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.fonts;
in {
  imports = [];


  options.bead.fonts = {
    enableDefault = bead.mkBooleanOption true "Whether to install the default fonts bundled with the config";
    extraFonts = bead.mkListOfOption lib.types.package [] "Extra font packages to install into the system";
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
