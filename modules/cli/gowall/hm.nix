{ pkgs, lib, stellae, ... }:


let
  mkElementCfg = element: let
    colors = stellae.lib.elementToFormattedHex element;
  in ''
    - name: "STELLAE ${stellae.lib.strings.capitalize element.name}"
      colors:
        - "${colors.surface.crust}"
        - "${colors.surface.mantle}"
        - "${colors.surface.base}"
        - "${colors.surface.surface0}"
        - "${colors.surface.surface1}"
        - "${colors.surface.overlay0}"
        - "${colors.surface.overlay1}"
        - "${colors.surface.subtext0}"
        - "${colors.surface.subtext1}"
        - "${colors.surface.text}"
        - "${colors.accent.red}"
        - "${colors.accent.light_red}"
        - "${colors.accent.orange}"
        - "${colors.accent.light_orange}"
        - "${colors.accent.yellow}"
        - "${colors.accent.light_yellow}"
        - "${colors.accent.green}"
        - "${colors.accent.light_green}"
        - "${colors.accent.blue}"
        - "${colors.accent.light_blue}"
        - "${colors.accent.purple}"
        - "${colors.accent.light_purple}"
        - "${colors.accent.magenta}"
        - "${colors.accent.light_magenta}"
  '';

  allElementsCfg = lib.concatStringsSep "\n\n" (
    lib.mapAttrsToList (_: element: "${mkElementCfg element}")
  stellae.elements);

in {
  home.packages = [ pkgs.gowall ];
  home.file.".config/gowall/config.yml".text = ''
    themes:
    ${stellae.lib.strings.indent 2 allElementsCfg}
  '';
}
