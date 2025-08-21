# TODO: STELLAE Themeing Input
#   - Tmux
#   - Nvim (Passing STELLAE to Zenvim input)
#   - Tofi
#   - Hyprland
#   - Kitty
#   - Dunst

{
  description = "Luna Skye's NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zenvim.url = "github:luna-skye/nvim";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, sops-nix, ... }:
  let
    inherit (inputs.nixpkgs) lib;
    helpers = import ./helpers { inherit self; inherit inputs; };

    mkHmUser = user: {
      name = user;
      value.imports = [
        (./modules/hm.nix)
        (./users + "/${user}")
      ];
    };

    mkNixosHost = host: users: lib.nixosSystem {
      specialArgs = { inherit inputs; inherit helpers; };
      modules = [
        inputs.musnix.nixosModules.musnix
        sops-nix.nixosModules.sops

        (./modules/nixos.nix)
        (./hosts + "/${host}/hardware.nix")
        (./hosts + "/${host}/configuration.nix")
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; inherit self; inherit helpers; };
          home-manager.users = builtins.listToAttrs (map (user: mkHmUser user) users);
        }
      ];
    };
  in {
    nixosConfigurations = {
      luna = mkNixosHost "luna" [ "skye" ];
      mimas = mkNixosHost "mimas" [ "skye" ];
      narvi = mkNixosHost "narvi" [ "steve" ];
    };
  };
}
