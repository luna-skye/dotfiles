{ config, lib, bead, ... }: let
  cfg = config.bead.cli.shell;
in {
  imports = [];


  options.bead.cli.shell = {
    #  TODO: Implement control over default shell
    #  NOTE: This might be complicated, see: https://github.com/nix-community/home-manager/issues/2209
    defaultShell = lib.mkOption {
      description = "Sets which installed shell to use as the user's default";
      type = lib.types.enum [ "bash" "fish" "nu" ];
      default = "fish";
    };

    fish = {
      enable = bead.mkBooleanOption true "Whether to enable the Fish shell";

      enableDefaultAliases = bead.mkBooleanOption true "Whether to enable the default provided aliases for Fish shell";
      aliases = lib.mkOption {
        description = "Shell aliases to register in Fish for the user";
        type = lib.types.attrs;
        default = {};
      };
    };

    nushell = {
      enable = bead.mkBooleanOption true "Whether to enable the Nu shell";

      enableDefaultAliases = bead.mkBooleanOption true "Whether to enable the default provided aliases for Nushell";
      aliases = lib.mkOption {
        description = "Shell aliases to register in Nushell for the user";
        type = lib.types.attrs;
        default = {};
      };
    };
  };


  config = {
    programs.fish = lib.mkIf (cfg.fish.enable) {
      enable = true;

      shellInit = ''
        set -U fish_greeting
        set -U fish_autosuggestion_accept none
      '';

      shellAliases = (if (cfg.fish.enableDefaultAliases) then {
        ".." = "cd ..";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";

        mkdir = "mkdir -pv"; # make parent dirs on demand
      } else {}) // cfg.fish.aliases;
    };

    programs.nushell = lib.mkIf (cfg.nushell.enable) {
      enable = true;

      configFile = { text =  ''
        $env.config = {
          show_banner: false,
        }
      ''; };

      shellAliases = (if (cfg.nushell.enableDefaultAliases) then {

      } else {}) // cfg.nushell.aliases;
    };
  };
}
