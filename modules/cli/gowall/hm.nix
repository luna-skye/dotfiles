{ inputs, pkgs, lib, ... }:


let
  stellae = inputs.stellae-nix.lib;
  toHex = c: "#${stellae.colors.hslToHex c}";

  capitalize = str: lib.strings.toUpper(lib.substring 0 1 str) + lib.substring 1 (-1) str;

  indent = n: str: let
    pad = builtins.concatStringsSep "" (builtins.genList (_: " ") n);
  in builtins.concatStringsSep "\n" (map (line: pad + line) (lib.splitString "\n" str));

  mkElementCfg = name: element: let
    el = stellae.colors.convertElementTokens element;
  in ''
    - name: "STELLAE ${capitalize name}"
      colors:
        - "${toHex el.surface.crust}"
        - "${toHex el.surface.mantle}"
        - "${toHex el.surface.base}"
        - "${toHex el.surface.surface0}"
        - "${toHex el.surface.surface1}"
        - "${toHex el.surface.overlay0}"
        - "${toHex el.surface.overlay1}"
        - "${toHex el.surface.subtext0}"
        - "${toHex el.surface.subtext1}"
        - "${toHex el.surface.text}"
        - "${toHex el.accent.red}"
        - "${toHex el.accent.light_red}"
        - "${toHex el.accent.orange}"
        - "${toHex el.accent.light_orange}"
        - "${toHex el.accent.yellow}"
        - "${toHex el.accent.light_yellow}"
        - "${toHex el.accent.green}"
        - "${toHex el.accent.light_green}"
        - "${toHex el.accent.blue}"
        - "${toHex el.accent.light_blue}"
        - "${toHex el.accent.purple}"
        - "${toHex el.accent.light_purple}"
        - "${toHex el.accent.magenta}"
        - "${toHex el.accent.light_magenta}"
  '';

  allElementsCfg = lib.concatStringsSep "\n\n" (lib.mapAttrsToList (name: element: "${mkElementCfg name element}") stellae.elements);

in {
  home.packages = [ pkgs.gowall ];
  home.file.".config/gowall/config.yml".text = ''
    themes:
    ${indent 2 allElementsCfg}
  '';
}
