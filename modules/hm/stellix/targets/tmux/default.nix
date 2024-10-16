{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.stellix.targets.tmux;

  colors = config.bead.stellix.palette;
  colPrimary = builtins.attrsets.attrByPath [ "accent" colors.primary ] "#FF0000" colors;
  # colSecondary = builtins.attrsets.attrByPath [ "accent" colors.secondary ] "#FF0000" colors;

  tmux-nova = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "nova";
    version = "unstable-2024-09-21";
    src = pkgs.fetchFromGitHub {
      owner = "o0th";
      repo = "tmux-nova";
      rev = "6c8fc10d3daa03f400ea9000f9321d8332eab229";
      sha256 = "sha256-0LIql8as2+OendEHVqR0F3pmQTxC1oqapwhxT+34lJo=";
    };
  };
in {
  imports = [];


  options.bead.stellix.targets.tmux = {
    enable = bead.mkBooleanOption true "Whether to enable Tmux overrides from STELLIX";
  };


  config = lib.mkIf (cfg.enable) {
    programs.tmux.plugins = [
      { plugin = pkgs.tmuxPlugins.cpu; }
      { 
        plugin = tmux-nova;
        extraConfig = /* bash */ ''
          set -g @plugin 'o0th/tmux-nova'
          set -g @nova-nerdfonts true
          set -g @nova-nerdfonts-left 
          set -g @nova-nerdfonts-right 

          set -g @nova-pane-active-border-style "${colPrimary}"
          set -g @nova-pane-border-style "${colors.surface.surface0}"

          set -g @nova-status-style-bg "${colors.surface.base}"
          set -g @nova-status-style-fg "${colors.surface.subtext0}"
          set -g @nova-status-style-active-bg "${colors.surface.surface1}"
          set -g @nova-status-style-active-fg "${colPrimary}"
          set -g @nova-status-style-double-bg "${colors.surface.base}"

          set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

          set -g @nova-segment-mode "#{?client_prefix,󰫈,󰋙}"
          set -g @nova-segment-mode-colors "${colors.surface.surface0} ${colPrimary}"

          set -g @nova-segment-whoami "#(whoami)@#h"
          set -g @nova-segment-whoami-colors "${colors.surface.surface0} ${colPrimary}"


          set -g @cpu_percentage_format "%5.1f%%"
          set -g @nova-segment-cpu " #(${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/scripts/cpu_percentage.sh)"
          set -g @nova-segment-cpu-colors "${colors.surface.base} ${colors.surface.subtext0}"

          set -g @ram_percentage_format "%5.1f%%"
          set -g @nova-segment-ram " #(${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/scripts/ram_percentage.sh)"
          set -g @nova-segment-ram-colors "${colors.surface.base} ${colors.surface.subtext0}"

          set -g @nova-rows 0
          set -g @nova-segments-0-left "mode"
          set -g @nova-segments-0-right "cpu ram whoami"
        '';
      }
    ];
  };
}
