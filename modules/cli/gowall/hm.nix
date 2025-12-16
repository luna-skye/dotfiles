{ pkgs, lib, stellae, ... }:


let
  toHex = c: "#${stellae.lib.hslToHex c}";
  mkElementCfg = name: element: ''
    - name: "STELLAE ${stellae.lib.strings.capitalize name}"
      colors:
        - "${toHex element.surface.crust}"
        - "${toHex element.surface.mantle}"
        - "${toHex element.surface.base}"
        - "${toHex element.surface.surface0}"
        - "${toHex element.surface.surface1}"
        - "${toHex element.surface.overlay0}"
        - "${toHex element.surface.overlay1}"
        - "${toHex element.surface.subtext0}"
        - "${toHex element.surface.subtext1}"
        - "${toHex element.surface.text}"
        - "${toHex element.accent.red}"
        - "${toHex element.accent.light_red}"
        - "${toHex element.accent.orange}"
        - "${toHex element.accent.light_orange}"
        - "${toHex element.accent.yellow}"
        - "${toHex element.accent.light_yellow}"
        - "${toHex element.accent.green}"
        - "${toHex element.accent.light_green}"
        - "${toHex element.accent.blue}"
        - "${toHex element.accent.light_blue}"
        - "${toHex element.accent.purple}"
        - "${toHex element.accent.light_purple}"
        - "${toHex element.accent.magenta}"
        - "${toHex element.accent.light_magenta}"
  '';

  allElementsCfg = lib.concatStringsSep "\n\n" (lib.mapAttrsToList (name: element: "${mkElementCfg name element}") stellae.elements);

in {
  home.packages = [ pkgs.gowall ];
  home.file.".config/gowall/config.yml".text = ''
    themes:
    ${stellae.lib.strings.indent 2 allElementsCfg}
  '';
}
