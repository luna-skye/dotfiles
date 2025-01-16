{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.cli.shell.fish;
in {
  imports = [];


  options.bead.cli.shell.fish = {
    enable = helpers.mkBooleanOption true "Whether to enable the Fish shell";

    enableDefaultAbbrs = helpers.mkBooleanOption true "Whether to enable the default provided abbreviations for Fish shell";
    abbrs = lib.mkOption {
      description = "Shell aliases to register in Fish for the user";
      type = lib.types.attrs;
      default = {};
    };

    enableDefaultAliases = helpers.mkBooleanOption true "Whether to enable the default provided aliases for Fish shell";
    aliases = lib.mkOption {
      description = "Shell aliases to register in Fish for the user";
      type = lib.types.attrs;
      default = {};
    };
  };
  

  config = lib.mkIf (cfg.enable) {
    home.file.".config/fish/functions".source = ./functions;

    programs.fish = {
      enable = lib.mkDefault true;

      shellInit = ''
        set -U fish_greeting
        set -U fish_autosuggestion_accept none
      '';

      shellAbbrs = (if (cfg.enableDefaultAbbrs) then {
        ".files" = "cd ~/dotfiles";
        h = "history";
        x = "exit";
        c = "clear";
        lns = "ln -s";
        mkdirp = "mkdir -p";
        cpr = "cp -R";
        chx = "chmod +x";
        chr = "chmod -R";

        # Git
        g   = "git";
        gs  = "git status";
        ga  = "git add";
        gaa = "git add all";
        gc  = "git commit";
        gco = "git checkout";
        gp  = "git push";
        gpl = "git pull";
        gcl = "git clone";
        gf  = "git fetch";
        gr  = "git remote";
        grb = "git rebase";
        gb  = "git branch";
        gd  = "git diff";
        gl  = "git log";

        # Tmux
        t  = "tmux";
        tl = "tmux ls";
        ta = "tmux attach -t";
        tk = "tmux kill-session -t";

        # Misc.
        ff = "clear && fastfetch";
      } else {}) // cfg.abbrs;

      shellAliases = (if (cfg.enableDefaultAliases) then {
        tree = ''${lib.getExe pkgs.eza} --tree --icons'';
        l    = ''${lib.getExe pkgs.eza} -h --git --icons --color=auto --group-directories-first -s extension'';
        ls   = ''${lib.getExe pkgs.eza} -l --icons --color=auto --group-directories-first'';
        "l." = ''${lib.getExe pkgs.eza} -l -d .* --icons --color=auto --group-directories-first'';

        ytmp3 = ''${lib.getExe pkgs.yt-dlp} -x --continue --prefer-ffmpeg --embed-thumbnail --audio-format mp3 --audio-quality 0 --add-meta-data --metadata-from-title"%(artist)s - %{title}s" -o "%(title)s.%(ext)s"'';
        ytmp4 = ''${lib.getExe pkgs.yt-dlp} -x --continue --prefer-ffmpeg --embed-thumbnail --format "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" -o "%(title)s.%(ext)s"'';
        ytogg = ''${lib.getExe pkgs.yt-dlp} -x --continue --prefer-ffmpeg --remux-video ogg --audio-quality 0 -o "%(title)s.%(ext)s"'';
      } else {}) // cfg.aliases;
    };
  };
}
