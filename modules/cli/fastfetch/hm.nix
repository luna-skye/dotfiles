{ lib, ... }:

let
  inherit (lib) mkDefault;

in {
  imports = [];
  options.zen.cli.fastfetch = {};
  config = {
    programs.fastfetch = {
      enable = mkDefault true;
      settings = {
        logo = {
          source = mkDefault "~/.config/totality-nixos/logo.png";
          padding = {
            right = mkDefault 2;
            left = mkDefault 2;
            top = mkDefault 1;
          };
        };

        modules = mkDefault [
          "break"
          { type = "os";       key = " OS";         keyColor = "cyan"; }
          { type = "kernel";   key = "├  Kernel";   keyColor = "cyan"; }
          { type = "packages"; key = "├ 󰏖 Packages"; keyColor = "cyan"; }
          { type = "terminal"; key = "├  Terminal"; keyColor = "cyan"; }
          { type = "shell";    key = "├  Shell";    keyColor = "cyan"; }
          { type = "wm";       key = "├  DE/WM";    keyColor = "cyan"; }
          { type = "colors";   key = "└ 󰌁 Colors";   keyColor = "cyan"; symbol = "circle"; }
          "break"
          { type = "host";    key = "󰇅 Host";                keyColor = "yellow"; }
          { type = "cpu";     key = "├  CPU";               keyColor = "yellow"; }
          { type = "memory";  key = "├  RAM";               keyColor = "yellow"; }
          { type = "swap";    key = "├ 󰓡 Swap";              keyColor = "yellow"; }
          { type = "gpu";     key = "├ 󰍛 GPU";               keyColor = "yellow"; }
          { type = "custom";  key = "├ 󰍹 Displays";          keyColor = "yellow"; }
          { type = "display"; key = "│ ├ {name}";            keyColor = "yellow"; }
          { type = "custom";  key = "├  Disks";             keyColor = "yellow"; }
          { type = "disk";    key = "│ ├ {name} ({1})";      keyColor = "yellow"; }
          { type = "localip"; key = "├  Local IP ({name})"; keyColor = "yellow"; }
          { type = "uptime";  key = "└ 󰅐 Uptime";            keyColor = "yellow"; }
          "break"
        ];
      };
    };
  };
}
