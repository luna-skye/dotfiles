{ config, lib, bead, ... }: let
  cfg = config.bead.cli.git;
in {
  imports = [];


  options.bead.cli.git = {
    username = bead.mkStringOption "" "The username to use for Git commits";
    email = bead.mkStringOption "" "The email address to use for Git commits";

    initBranch = bead.mkStringOption "main" "The default branch of newly initialized git project";

    enableDefaultIgnores = bead.mkBooleanOption true "Whether to enable the preconfigured ignore list";
    ignores = bead.mkListOfOption lib.types.str [] "List of file/dir globs to always ignore in git projects";

    enableDefaultAliases = bead.mkBooleanOption true "Whether to enable the preconfigured alias shorthands";
    aliases = lib.mkOption {
      type = lib.types.attrs;
      description = "Set of alias shorthands to register under the git command";
      default = {};
    };
  };


  config = {
    programs.git = {
      enable = lib.mkDefault true;
      lfs.enable = lib.mkDefault true;
      delta.enable = lib.mkDefault true;

      userName = lib.mkDefault cfg.username;
      userEmail = lib.mkDefault cfg.email;

      ignores = (if (config.bead.cli.git.enableDefaultIgnores) then [
        ".cache/"
        ".DS_Store"
        ".idea/"
        "*.swp"
        "*.elc"
        ".direnv/"
        "node_modules"
        "result"
        "result-*"
      ] else []) ++ config.bead.cli.git.ignores;

      extraConfig = {
        init.defaultBranch = lib.mkDefault config.bead.cli.git.initBranch;

        delta = {
          options.map-styles = lib.mkDefault "bold purple => syntax #ca9ee6, bold cyan => syntax #8caaee";
          line-numbers = lib.mkDefault true;
        };

        branch.autosetupmerge = lib.mkDefault true;
        push.default = lib.mkDefault "current";
        merge.stat = lib.mkDefault true;

        pull.ff = lib.mkDefault "only";
        rebase = {
          autoSquash = lib.mkDefault true;
          autoStash = lib.mkDefault true;
        };
      };

      aliases = (if (config.bead.cli.git.enableDefaultAliases) then {
        # historical viewing
        graph = "log --all --graph --decorate --oneline";
        hist = ''log --graph --date=relative --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%Creset" --decorate --all'';
        llog = ''log --graph --date=relative --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset)" --name-status'';
      } else {}) // config.bead.cli.git.aliases;
    };
  };
}
