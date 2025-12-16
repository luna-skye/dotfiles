{ lib, pkgs, ... }:


let
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
  config = {
    programs.tmux = {
      enable = lib.mkDefault true;

      shell = lib.mkDefault (lib.getExe pkgs.fish);
      mouse = lib.mkDefault true;
      clock24 = lib.mkDefault true;
      keyMode = lib.mkDefault "vi";
      sensibleOnTop = lib.mkDefault true;
      shortcut = lib.mkDefault "space";
      escapeTime = lib.mkDefault 20;      # low escape time to avoid delay on <Esc>
      newSession = lib.mkDefault true;    # spawn new session if trying to attach and none running

      tmuxp.enable = lib.mkDefault true; # enable tmuxp session manager

      plugins = [
        { plugin = pkgs.tmuxPlugins.cpu; }
        {
          plugin = tmux-nova;
          extraConfig = /* bash */ ''
            set -g @nova-nerdfonts true
            set -g @nova-nerdfonts-left 
            set -g @nova-nerdfonts-right 

            set -g @nova-pane-active-border-style "#B58DEE"
            set -g @nova-pane-border-style "#20203C"

            set -g @nova-status-style-bg "#151528"
            set -g @nova-status-style-fg "#8787D9"
            set -g @nova-status-style-active-bg "#35355F"
            set -g @nova-status-style-active-fg "#B58DEE"
            set -g @nova-status-style-double-bg "#151528"

            set -g @nova-pane "#I#{?pane_in_mode,#{pane_mode},}  #W"

            set -g @nova-segment-mode "#{?client_prefix,,}"
            set -g @nova-segment-mode-colors "#20203C #B58DEE"

            set -g @nova-segment-whoami "#(whoami)@#h"
            set -g @nova-segment-whoami-colors "#20203C #B58DEE"


            set -g @cpu_percentage_format "%5.1f%%"
            set -g @nova-segment-cpu " #(${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/scripts/cpu_percentage.sh)"
            set -g @nova-segment-cpu-colors "#151528 #8787D9"

            set -g @ram_percentage_format "%5.1f%%"
            set -g @nova-segment-ram " #(${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/scripts/ram_percentage.sh)"
            set -g @nova-segment-ram-colors "#151528 #8787D9"

            set -g @nova-rows 0
            set -g @nova-segments-0-left "mode"
            set -g @nova-segments-0-right "cpu ram whoami"
          '';
        }
      ];

      extraConfig = /* bash */ ''
        set -g status-position top

        # set default to 256 color terminal (fixes nvim/hx issues)
        set -g default-terminal "tmux-256color"

        # unbind ctrl+b prefix, swap with ctrl+space
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix

        # config from vim-tmux-navigator
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l

        # start windows and panes at index 1, not index 0
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # keybinds
        bind-key -T copy-mode-vi v send-keys -X begin-selection # v to enter selection mode
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle # toggle rectangle vs. line selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # split pane at cwd
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
      '';
    };
  };
}
