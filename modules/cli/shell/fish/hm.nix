{ config, lib, helpers, pkgs, ... }:

let
  cfg = config.zen.cli.shell.fish;

in {
  imports = [];

  options.zen.cli.shell.fish = {
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
  
  config = {
    home.file.".config/fish/functions".source = ./functions;
    programs.fish = {
      enable = lib.mkDefault true;
      shellInit = ''
        set -U fish_greeting
        set -U fish_autosuggestion_accept none
        direnv hook fish | source
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

        t  = "tmux";
        tl = "tmux ls";
        ta = "tmux attach -t";
        tk = "tmux kill-session -t";

        ff = "clear && fastfetch";
      } else {}) // cfg.abbrs;

      shellAliases = (if (cfg.enableDefaultAliases) then let
        eza   = lib.getExe pkgs.eza;
        ytdlp = lib.getExe pkgs.yt-dlp;
      in {
        gitviz = "${lib.getExe pkgs.gource} -f --frameless --highlight-dirs -s 90 --filename-time 15 --no-vsync --padding 1 --key --background 080814 --hash-seed 18 --user-image-dir ~/.avatars";

        tree = ''${eza} --tree --icons'';
        l    = ''${eza} -h --git --icons --color=auto --group-directories-first -s extension'';
        ls   = ''${eza} -l --icons --color=auto --group-directories-first'';
        "l." = ''${eza} -l -d .* --icons --color=auto --group-directories-first'';

        ytmp3 = ''${ytdlp} -x --continue --prefer-ffmpeg --embed-thumbnail --audio-format mp3 --audio-quality 0 --add-meta-data --metadata-from-title"%(artist)s - %{title}s" -o "%(title)s.%(ext)s"'';
        ytmp4 = ''${ytdlp} -x --continue --prefer-ffmpeg --embed-thumbnail --format "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" -o "%(title)s.%(ext)s"'';
        ytogg = ''${ytdlp} -x --continue --prefer-ffmpeg --remux-video ogg --audio-quality 0 -o "%(title)s.%(ext)s"'';
      } else {}) // cfg.aliases;
    };

    # Desktop file for nixup function
    xdg.desktopEntries.nixup = {
      name = "Nix Update";
      genericName = "Sync NixOS dotfiles and rebuild";
      icon = "nix-snowflake";
      exec = "fish -c nixup";
      terminal = true;
      categories = [ "System" ];
    };
  };
}
