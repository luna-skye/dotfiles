{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
in {
  # Creates a Nix Option of the boolean type, with a passed doc description and default value
  mkBooleanOption = default: desc: lib.mkOption {
    description = desc;
    type = lib.types.bool;
    default = default;
  };

  # Creates a Nix Option of the number type, with a passed doc description and default value
  mkNumberOption = default: desc: lib.mkOption {
    description = desc;
    type = lib.types.number;
    default = default;
  };
  
  # Creates a Nix Option of the string type, with a passed doc description and default value
  mkStringOption = default: desc: lib.mkOption {
    description = desc;
    type = lib.types.str;
    default = default;
  };
  
  # Creates a Nix Option of an enumerator type, with passed options, a doc description, and default value
  mkEnumOption = opts: default: desc: lib.mkOption {
    description = desc;
    type = lib.types.enum opts;
    default = default;
  };

  # Creates a Nix Option of a list type, where items are of the passed `type`, with a passed doc description and default value
  mkListOfOption = type: default: desc: lib.mkOption {
    description = desc;
    type = lib.types.listOf type;
    default = default;
  };

  # Creates a nullable Nix Option of a generic type, with passed doc description and default value
  mkNullOrOption = type: default: desc: lib.mkOption {
    description = desc;
    type = lib.types.nullOr type;
    default = default;
  };
}
