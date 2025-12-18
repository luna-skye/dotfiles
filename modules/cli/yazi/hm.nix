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

    home.file.".config/yazi/theme.toml".text = stellae.exporters.yazi.plaintext { inherit (config.zen.theme) element; };

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

    home.file.".config/yazi/init.lua".text = /* lua */ ''
      -- show username/hostname in header
      Header:children_add(function()
        if ya.target_family() ~= "unix" then
          return ""
        end
        return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
      end, 500, Header.LEFT)

      -- show user/group of files in status bar
      Status:children_add(function()
        local h = cx.active.current.hovered
        if not h or ya.target_family() ~= "unix" then
          return ""
        end

        return ui.Line {
          ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
          ":",
          ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
          " ",
        }
      end, 500, Status.RIGHT)
    '';
  };
}
