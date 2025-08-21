{ ... }:

{
  imports = [];

  options.zen.cli.shell.nushell = {};

  config = {
    programs.nushell = {
      enable = true;
      configFile.text =  ''
        $env.config = {
          show_banner: false,
        }

        { ||
          if (which direnv | is-empty) {
            return
          }

          direnv export json | from json | default {} | load-env
        }
      '';
      shellAliases = {};
    };
  };
}
