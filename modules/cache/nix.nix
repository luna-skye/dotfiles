{ config, lib, bead, ... }: {
  imports = [];


  options.bead.cache = {
    enable = bead.mkBooleanOption true "Whether to enable the use of binary caches when building the NixOS system";

    useDefaults = bead.mkBooleanOption true "Whether to use default substituters and trusted keys for caches";

    #  TODO: add options for expanding defaults
  };


  config = lib.mkIf (config.bead.cache.enable) {
    nix.settings = {
      builders-use-substitutes = true;

      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
