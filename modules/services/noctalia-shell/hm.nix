{ inputs, osConfig, config, lib, stellae, ... }:

let
  inherit (lib) mkDefault;
  hostCfg = osConfig.zen.services.noctalia-shell;
  colors = stellae.lib.elementToFormattedHex config.zen.theme.element;

in {
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf (hostCfg.enable) {
    programs.noctalia-shell = {
      enable = mkDefault true;

      colors = {
        # Accents
        mError            = colors.tokens.error;
        mPrimary          = colors.tokens.primary;
        mSecondary        = colors.tokens.secondary;
        mTertiary         = colors.tokens.secondary;

        # Surfaces
        mOutline          = colors.surface.surface1;
        mSurface          = colors.surface.base;
        mSurfaceVariant   = colors.surface.surface0;
        mHover            = colors.surface.surface1;
        mShadow           = colors.surface.crust;

        # Text
        mOnError          = colors.surface.crust;
        mOnPrimary        = colors.surface.crust;
        mOnSecondary      = colors.surface.crust;
        mOnTertiary       = colors.surface.crust;
        mOnSurface        = colors.surface.subtext1;
        mOnSurfaceVariant = colors.surface.subtext1;
        mOnHover          = colors.surface.text;
      };

      settings = import ./settings { inherit osConfig config; };
    };
  };
}
