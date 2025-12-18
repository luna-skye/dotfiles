{ config, lib, helpers, stellae, ... }:

let
  cfg = config.zen.cli.yazi;

in {
  imports = [];

  options.zen.cli.yazi = {
    enable = helpers.mkBooleanOption true "Whether to install and configure Yazi for the user";
    enableYyCommand = helpers.mkBooleanOption true "Whether to enable the `yy` shortcut for persistent yazi navigation";
  };

  config = lib.mkIf (cfg.enable) {
    programs.yazi.enable = lib.mkDefault true;

    home.file = {
      ".config/yazi/theme.toml".text = stellae.exporters.yazi.plaintext { inherit (config.zen.theme) element; };
      ".config/yazi/yazi.toml".text = builtins.readFile ./yazi.toml;
      ".config/yazi/init.lua".text = builtins.readFile ./init.lua;
    };
  };
}
