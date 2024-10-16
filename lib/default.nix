{ self, inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
  mkOptions = import ./mkOptions.nix { inherit inputs; };
in
  mkOptions // {
  # Returns a boolean representing whether or not ANY configured hm user has a specific boolean option enabled 
  # Takes in a list of strings representing the config option path, and requires the config attrset to be passed
  # 
  # ## Arguments
  # - `configPath`: Configuration path to check value for, as a Nix String List
  # - `config`: A reference to the config set to check against for users, expects hm config scope
  anyUserHasEnabled = configPath: config: lib.any (user:
    let
      value = lib.attrsets.attrByPath configPath false user;
    in
      lib.isBool value && value
  ) (lib.attrValues config.home-manager.users);


  # Returns a list of usernames for every home-manager user which has the specified boolean option enabled
  # Takes a list of strings representing the config option path, and requires the config attrset to be passed
  # 
  # ## Arguments
  # - `configPath`: Configuration path to check value for, as a Nix String list
  # - `config`: A reference to the config set to check against, expects nix config
  usersWithEnabled = configPath: config: lib.filter(user:
    let value = lib.attrsets.attrByPath configPath false user;
    in lib.isBool value && value
  ) (lib.attrValues config.home-manager.users);


  # Returns a list of all default.nix module entry points within a provided directory.
  # 
  # ## Arguments
  # - `dir`: The directory to crawl for module entry points
  #  TODO: Figure out way around lib.toPath deprecation, not able to use the new solution, might be a good reason for that
  autoload = dir: builtins.concatLists (lib.mapAttrsToList (path: kind: 
    if kind == "directory"
      then let
        file = "${builtins.toPath dir}/${path}/default.nix";
      in if builtins.pathExists file then [ file ] else [ ]
      else [ ])
  (builtins.readDir dir));
}
