{ helpers, ... }: {
  imports = helpers.getScopedSubmodules ../apps "nix";
}
