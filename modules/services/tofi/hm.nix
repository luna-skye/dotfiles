{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.services.tofi;

  configMenuScript = pkgs.writeShellScript "config-menu" /* bash */ ''
    dotf=' NixOS Dotfiles'
    iodf=' IO (Homelab) Dotfiles'
    nvim=' Neovim Dotfiles'
    astl='󱍕 Astal Dotfiles'
    stel=' STELLAE Project'

    chosen=$(
      printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n' "$dotf" "$iodf" "$nvim" "$stel" | tofi
    )

    case "$chosen" in
      "$dotf") kitty --directory ~/dotfiles/ -e vi ;;
      "$iodf") kitty --directory ~/projects/sysadm/io/ -e vi ;;
      "$nvim") kitty --directory ~/projects/sysadm/nvim/ -e vi ;;
      "$astl") kitty --directory ~/projects/sysadm/astal/ -e vi ;;
      "$stel") kitty --directory ~/projects/code/stellae/ -e vi ;;

    *) exit 1 ;;
    esac
  '';

in {
  options.zen.scripts.configMenu = lib.mkOption {
    description = "Dmenu script for editing dotfile configurations";
    type = lib.types.package;
    default = null;
  };
  config = lib.mkIf (hostCfg.enable) {
    zen.scripts.configMenu = configMenuScript;
    programs.tofi = {
      enable = true;
      settings = {
        width = "100%";
        height = "100%";
        border-width = 0;
        outline-width = 0;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = 8;
        num-results = 8;
        prompt-text = " Run ";
        prompt-padding = 16;
        font = "monospace";
        background-color = "#090915AA";
        text-color = "#3c4178";
        selection-color = "#ff64ff";
      };
    };

  };
}
