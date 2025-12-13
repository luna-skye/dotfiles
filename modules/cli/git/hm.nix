{ config, lib, helpers, ... }:

let
  cfg = config.zen.cli.git;

in {
  imports = [];

  options.zen.cli.git = {
    username = helpers.mkStringOption "" "The username to use for Git commits";
    email = helpers.mkStringOption "" "The email address to use for Git commits";

    initBranch = helpers.mkStringOption "main" "The default branch of newly initialized git projects";

    enableDefaultIgnores = helpers.mkBooleanOption true "Whether to enable the preconfigured ignore list";
    ignores = helpers.mkListOfOption lib.types.str [] "List of file/dir globs to always ignore in git projects";

    enableDefaultAliases = helpers.mkBooleanOption true "Whether to enable the preconfigured alias shorthands";
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

      settings = {
        user.name = lib.mkDefault cfg.username;
        user.email = lib.mkDefault cfg.email;

        aliases = (if (cfg.enableDefaultAliases) then {
          # historical viewing
          graph = "log --all --graph --decorate --oneline";
          hist = ''log --graph --date=relative --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%Creset" --decorate --all'';
          llog = ''log --graph --date=relative --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset)" --name-status'';
        } else {}) // cfg.aliases;

        init.defaultBranch = lib.mkDefault cfg.initBranch;

        branch.autosetupmerge = lib.mkDefault true;
        push.default = lib.mkDefault "current";
        merge.stat = lib.mkDefault true;

        pull.ff = lib.mkDefault "only";
        rebase = {
          autoSquash = lib.mkDefault true;
          autoStash = lib.mkDefault true;
        };
      };

      ignores = (if (cfg.enableDefaultIgnores) then [
        ".cache/"
        ".DS_Store"
        ".idea/"
        "*.swp"
        "*.elc"
        ".direnv/"
        "node_modules"
        "result"
        "result-*"
      ] else []) ++ cfg.ignores;
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options.map-styles = lib.mkDefault "bold purple => syntax #ca9ee6, bold cyan => syntax #8caaee";
    };
  };
}
