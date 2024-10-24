{ config, lib, bead, ... }: let
  cfg = config.bead.cli.fastfetch;
in {

  imports = [];

  options.bead.cli.fastfetch = {
    enable = bead.mkBooleanOption true "Whether to enable the Fastfetch CLI utility";
  };
  
  config = lib.mkIf (cfg.enable) {
    programs.fastfetch = {
      enable = lib.mkDefault true;
      settings = {
        logo = {
          source = lib.mkDefault "~/.config/totality-nixos/logo.jpg";
          padding = {
            right = lib.mkDefault 2;
            left = lib.mkDefault 2;
            top = lib.mkDefault 1;
          };
        };

        modules = lib.mkDefault [
          "break"
          { type = "os";       key = "{icon} OS";    keyColor = "magenta"; }
          { type = "kernel";   key = "├  Kernel";   keyColor = "magenta"; }
          { type = "packages"; key = "├ 󰏖 Packages"; keyColor = "magenta"; }
          { type = "terminal"; key = "├  Terminal"; keyColor = "magenta"; }
          { type = "shell";    key = "├  Shell";    keyColor = "magenta"; }
          { type = "wm";       key = "└  DE/WM";    keyColor = "magenta"; }
          "break"
          { type = "host";    key = "󰌢 Host";                keyColor = "yellow"; }
          { type = "cpu";     key = "├ 󰻠 CPU";               keyColor = "yellow"; }
          { type = "memory";  key = "├ 󰑭 RAM";               keyColor = "yellow"; }
          { type = "swap";    key = "├ 󰓡 Swap";              keyColor = "yellow"; }
          { type = "gpu";     key = "├ 󰍛 GPU";               keyColor = "yellow"; }
          { type = "custom";  key = "├ 󰍹 Displays";          keyColor = "yellow"; }
          { type = "display"; key = "│ ├ {name}";            keyColor = "yellow"; }
          { type = "custom";  key = "├  Disks";             keyColor = "yellow"; }
          { type = "disk";    key = "│ ├ {name} ({path})";   keyColor = "yellow"; }
          { type = "localip"; key = "├  Local IP ({name})"; keyColor = "yellow"; }
          { type = "uptime";  key = "├ 󰅐 Uptime";            keyColor = "yellow"; }
          "break"
        ];
      };
    };
  };
}
