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
  usersWithEnabled = configPath: config: lib.attrNames (lib.filterAttrs (userName: userCfg:
    (lib.getAttrFromPath configPath userCfg) == true
  ) config.home-manager.users);


  #  FIX: The following functions rely on the long deprecated builtin function `toPath`
  #  SEE: https://nixos.wiki/wiki/Nix_Language:_Tips_%26_Tricks#Convert_a_string_to_an_.28import-able.29_path
  #  AND: https://github.com/NixOS/nix/issues/1074
  #  AND: https://github.com/NixOS/nix/pull/2524

  # Returns a list of all default.nix submodule entry points within a provided directory
  # 
  # ## Arguments
  # - `dir`: The directory to crawl for submodule entry points
  getSubmodules = dir: builtins.concatLists (lib.mapAttrsToList (path: kind: 
    if kind == "directory"
      then let
        file = "${builtins.toPath dir}/${path}/default.nix";
      in if builtins.pathExists file then [ file ] else []
    else [])
  (builtins.readDir dir));


  # Returns a list of all scoped submodule entry points within a provided directory
  #
  # ## Arguments
  # - `dir`: The directory to crawl for submodule entry points
  # - `scope`: The scope entry point to look for and match against, i.e. "hm" or "nix"
  getScopedSubmodules = dir: scope: builtins.concatLists (lib.mapAttrsToList (path: kind:
    if (kind == "directory") then
      let
        named = "${builtins.toPath dir}/${path}/${scope}.nix";          # ex: session/hyprland/nix.nix
        scoped = "${builtins.toPath dir}/${path}/${scope}/default.nix"; # ex: session/hyprland/hm/default.nix
      in
        if (builtins.pathExists named) then [ named ] else (if (builtins.pathExists scoped) then [ scoped ] else [])
    else [])
  (builtins.readDir dir));
}
