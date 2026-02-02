{ config, lib, helpers, ... }:

let
  inherit (lib.lists) optionals;
  cfg = config.zen.cache;

in {
  imports = [];

  options.zen.cache = let
    substituterType = lib.types.submodule {
      url = helpers.mkStringOption "" "URL for the binary substituter";
      key = helpers.mkStringOption "" "Key for the binary substituter";
    };
  in {
    enable = helpers.mkBooleanOption true "Whether to enable the use of binary caches when building the NixOS system";
    useDefaultSubstituters = helpers.mkBooleanOption true "Whether to use default substituters and trusted keys for caches";
    extraSubstituters = helpers.mkListOfOption substituterType [] "Extra binary substituters and keys to add to a NixOS host";
  };

  config = lib.mkIf (cfg.enable) {
    nix.settings = {
      builders-use-substitutes = true;

      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];

      substituters = (builtins.map (item: item.url) cfg.extraSubstituters) ++ optionals (cfg.useDefaultSubstituters) [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];

      trusted-public-keys = (builtins.map (item: item.key) cfg.extraSubstituters) ++ optionals (cfg.useDefaultSubstituters) [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      ];
    };
  };
}
