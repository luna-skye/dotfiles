{ config, lib, helpers, ... }:

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

    home.file.".config/yazi/yazi.toml".text = /* toml */ ''
      [log]
      enabled = false

      [mgr]
      ratio = [3, 3, 3]
      show_hidden = false
      show_symlink = true
      sort_by = "natural"
      sort_dir_first = true

      [preview]
      tab_size = 2
    '';
  };
}
