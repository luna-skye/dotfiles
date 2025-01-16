{
  description = "NixOS Dotfiles written for and by Luna Skye";


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    inherit (inputs.nixpkgs) lib;
    helpers = import ./lib { inherit self; inherit inputs; };

    # Returns a named set which represents a hm user, including config module imports
    # 
    # ## Arguments
    # - `user`: The name of the home-manager user
    mkHmUser = user: {
      name = user;
      value.imports = [
        (./modules/hm.nix)
        (./users + "/${user}")
      ];
    };

    # Returns a NixOS System configured for the specified host with overlaid home-manager users
    # 
    # ## Arguments
    # - `host`: The name of the host system
    # - `users`: A list of string names for home-manager users to overlay onto the system
    mkNixosHost = host: users: lib.nixosSystem {
      specialArgs = { inherit inputs; inherit helpers; };
      modules = [
        (./hosts + "/${host}/hardware.nix")
        (./hosts + "/${host}/configuration.nix")

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; inherit self; inherit helpers; };
          home-manager.users = builtins.listToAttrs (map (user: mkHmUser user) users);
        }

        (./modules/nix.nix)
      ];
    };
  in {
    nixosConfigurations = {
      luna = mkNixosHost "luna" [ "skye" ];
      # mimas = mkNixosHost "mimas" [ "skye" ];
      # narvi = mkNixosHost "narvi" [ "slic" ];
    };

    genDocs = {};
  };
}
