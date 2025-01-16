{ config, lib, helpers, pkgs, ... }: let
  cfg = config.bead.cli.shell.nushell;
in {
  imports = [];


  options.bead.cli.shell.nushell = {
    enable = helpers.mkBooleanOption true "Whether to enable the Nu shell";

    enableDefaultAliases = helpers.mkBooleanOption true "Whether to enable the default provided aliases for Nushell";
    aliases = lib.mkOption {
      description = "Shell aliases to register in Nushell for the user";
      type = lib.types.attrs;
      default = {};
    };
  };


  config = lib.mkIf (cfg.enable) {
    programs.nushell = {
      enable = true;

      configFile = { text =  ''
        $env.config = {
          show_banner: false,
        }
      ''; };

      shellAliases = (if (cfg.enableDefaultAliases) then {

      } else {}) // cfg.aliases;
    };
  };
}
