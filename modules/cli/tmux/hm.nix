{ config, lib, pkgs, ... }: {
  imports = [];


  #  TODO: consider config options to expose for tmux
  options.bead.cli.tmux = {};


  config = {
    programs.tmux = {
      enable = lib.mkDefault true;

      #  FIX: this bad, shouldn't assume and should be user's preferred default
      shell = lib.mkDefault "${pkgs.fish}/bin/fish";

      mouse = lib.mkDefault true;
      clock24 = lib.mkDefault true;
      keyMode = lib.mkDefault "vi";
      sensibleOnTop = lib.mkDefault true;

      escapeTime = lib.mkDefault 20;      # low escape time to avoid delay on <Esc>
      newSession = lib.mkDefault true;    # spawn new session if trying to attach and none running
      shortcut   = lib.mkDefault "space"; # set shortcut to space

      tmuxp.enable = lib.mkDefault true; # enable tmuxp session manager

      extraConfig = /* bash */ ''
        # set default to 256 color terminal (fixes nvim/hx issues)
        set -g default-terminal "tmux-256color"

        # unbind ctrl+b prefix, swap with ctrl+space
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix


        # config from vim-tmux-navigator, allowing seamless navigation with our nvim config
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
