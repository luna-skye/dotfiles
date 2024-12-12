{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.services.walker;
in {
  imports = [];


  options.bead.services.walker = {
    enable = bead.mkBooleanOption false "Whether to enable the Walker application launcher";

    activationKeys = bead.mkStringOption "jkl;asdf" "Which keys to use for quick launch shortcuts";
    theme = bead.mkStringOption "catppuccin" "The theme name to use by default, loaded from `~/.config/walker/themes/`";
  };


  config = lib.mkIf (cfg.enable) {
    home.packages = builtins.attrValues { inherit (pkgs)
      walker
      libqalculate
      ;
    };

    home.file.".config/walker/config.json".text = builtins.toJSON {
      activation_mode = { labels = cfg.activationKeys; };
      as_window = false;
      force_keyboard_focus = true;
      theme = cfg.theme;

      list = {
        max_entries = 50;
        show_initial_entries = false;
        single_click = true;
      };
      search = {
        placeholder = "Search...";
        delay = 0;
        force_keyboard_focus = true;
        history = true;
      };

      builtins = {
        applications = {
          name = "applications";
          placeholder = "Applications";
          weight = 5;
          actions = false;
          context_aware = true;
          prioritize_new = false;
          refresh = true;
          show_generic = false;
          show_icon_when_single = true;
          show_sub_when_single = true;
        };
        calc = {
          name = "calc";
          placeholder = "Calculator";
          weight = 5;
          icon = "accessories-calculator";
          min_chars = 3;
        };
        clipboard = {
          name = "clipboard";
          placeholder = "Clipboard";
          weight = 5;
          image_height = 300;
          max_entries = 10;
          switcher_only = true;
        };
        commands = {
          name = "commands";
          placeholder = "Commands";
          weight = 5;
          icon = "utilities-terminal";
          switcher_only = true;
        };
        custom_commands = {
          name = "custom_commands";
          placeholder = "Custom Commands";
          weight = 5;
          icon = "utilities-terminal";
        };
        dmenu = {
          name = "dmenu";
          placeholder = "Dmenu";
          weight = 5;
          switcher_only = true;
        };
        emojis = {
          name = "emojis";
          placeholder = "Emojis";
          weight = 5;
          switcher_only = true;
          history = true;
          typeahead = true;
        };
        finder = {
          name = "finder";
          placeholder = "Finder";
          weight = 5;
          icon = "folder";
          switcher_only = true;
          concurrency = 8;
          refresh = true;
          ignore_gitignore = true;
        };
        runner = {
          name = "runner";
          placeholder = "Runner";
          weight = 5;
          icon = "utilities-terminal";
          history = true;
          refresh = true;
          typeahead = true;
        };
        ssh = {
          name = "ssh";
          placeholder = "SSH";
          weight = 5;
          icon = "preferences-system-network";
          history = true;
          refresh = true;
          switcher_only = true;
        };
        switcher = {
          name = "switcher";
          placeholder = "Switcher";
          prefix = "/";
          weight = 5;
        };
        websearch = {
          name = "websearch";
          placeholder = "Websearch";
          icon = "applications-internet";
          weight = 5;
          engines = [ "duckduckgo" ];
        };
        windows = {
          name = "windows";
          placeholder = "Windows";
          icon = "view-restore";
          weight = 5;
        };
      };
    };
  };
}
