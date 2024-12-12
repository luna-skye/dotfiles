# Loosely based on stylix: https://github.com/danth/stylix/blob/master/modules/yazi/hm.nix
# Which is based on the official yazi catppuccin theme: https://github.com/yazi-rs/themes
{ config, lib, bead, ... }: let
  cfg = config.bead.stellix.targets.yazi;
  colors = config.bead.stellix.palette;
in {
  imports = [];


  options.bead.stellix.targets.yazi = {
    enable = bead.mkBooleanOption false "Whether to enable Yazi as a target for STELLIX theming";
  };


  config = lib.mkIf (config.bead.stellix.enable && cfg.enable) {
    programs.yazi.theme = let
      inherit (lib) mkDefault;
      primaryColor = lib.attrsets.attrByPath [ "accent" colors.primary ] "#FF0000" colors;
      secondaryColor = lib.attrsets.attrByPath [ "accent" colors.secondary ] "#FF0000" colors;
    in {
      manager = rec {
        cwd             = mkDefault { fg = primaryColor; };
        hovered         = mkDefault { fg = colors.surface.text; bg = colors.surface.surface0; bold = true; };
        preview_hovered = mkDefault hovered;
        find_keyword    = mkDefault { fg = colors.accent.green; bold = true; };
        find_position   = mkDefault { fg = colors.surface.text; };

        marker_selected = mkDefault { fg = colors.accent.green;  bg = colors.accent.green; };
        marker_copied   = mkDefault { fg = colors.accent.yellow; bg = colors.accent.yellow; };
        marker_cut      = mkDefault { fg = colors.accent.red;    bg = colors.accent.red; };

        tab_active   = mkDefault { fg = primaryColor;            bg = colors.surface.mantle; };
        tab_inactive = mkDefault { fg = colors.surface.subtext0; bg = colors.surface.crust; };
        border_style = mkDefault { fg = colors.surface.surface1; };
      };

      status = {
        separator_style = mkDefault { fg = colors.surface.surface1; bg = colors.surface.surface1; };
        mode_normal = mkDefault { fg = colors.surface.crust; bg = colors.accent.blue; bold = true; };
        mode_select = mkDefault { fg = colors.surface.crust; bg = colors.accent.green; bold = true; };
        mode_unset  = mkDefault { fg = colors.surface.crust; bg = colors.accent.orange; bold = true; };

        progress_label  = mkDefault { fg = colors.surface.subtext0; bg = colors.surface.crust; };
        progress_normal = mkDefault { fg = colors.surface.subtext0; bg = colors.surface.crust; };
        progress_error  = mkDefault { fg = colors.accent.red;       bg = colors.surface.crust; };

        permissions_t = mkDefault { fg = colors.accent.blue; };
        permissions_r = mkDefault { fg = colors.accent.yellow; };
        permissions_w = mkDefault { fg = colors.accent.red; };
        permissions_x = mkDefault { fg = colors.accent.green; };
        permissions_s = mkDefault { fg = colors.accent.purple; };
      };

      select = {
        border = mkDefault { fg = colors.accent.blue; };
        active = mkDefault { fg = colors.accent.magenta; };
        inactive = mkDefault { fg = colors.surface.subtext0; };
      };

      input = {
        border   = mkDefault { fg = colors.accent.blue; };
        title    = mkDefault { fg = colors.surface.subtext0; };
        value    = mkDefault { fg = colors.surface.subtext1; };
        selected = mkDefault { bg = colors.surface.base; };
      };

      completion = {
        border = mkDefault { fg = colors.accent.blue; };
        active = mkDefault { fg = colors.accent.magenta; bg = colors.surface.base; };
        inactive = mkDefault { fg = colors.surface.subtext0; };
      };

      tasks = {
        border  = mkDefault { fg = colors.accent.blue; };
        title   = mkDefault { fg = colors.surface.subtext0; };
        hovered = mkDefault { fg = colors.surface.subtext0; bg = colors.surface.base; };
      };

      which = {
        mask = mkDefault { bg = colors.accent.red; };
        cand = mkDefault { fg = colors.accent.blue; };
        rest = mkDefault { fg = colors.accent.purple; };
        desc = mkDefault { fg = colors.surface.subtext0; };
        separator_style = mkDefault { fg = colors.surface.surface1; };
      };

      help = {
        on      = mkDefault { fg = colors.accent.magenta; };
        run     = mkDefault { fg = colors.accent.blue; };
        desc    = mkDefault { fg = colors.surface.subtext0; };
        hovered = mkDefault { fg = colors.surface.subtext0; bg = colors.surface.base; };
        footer  = mkDefault { fg = colors.surface.subtext0; };
      };

      filetype.rules = let
        mkRule = mime: fg: { inherit mime fg; };
      in [
        (mkRule "image/*" colors.accent.yellow)
        (mkRule "video/*" colors.accent.yellow)
        (mkRule "audio/*" colors.accent.blue)

        (mkRule "application/xz" colors.accent.green)
        (mkRule "application/zip" colors.accent.green)
        (mkRule "application/gzip" colors.accent.green)
        (mkRule "application/x-rar" colors.accent.green)
        (mkRule "application/x-tar" colors.accent.green)
        (mkRule "application/x-bzip" colors.accent.green)
        (mkRule "application/x-bzip2" colors.accent.green)
        (mkRule "application/x-7z-compressed" colors.accent.green)

        ((mkRule "inode/directory" primaryColor) //  { bold = true; })
        (mkRule "*" colors.surface.subtext0)
      ];
    };
  };
}
