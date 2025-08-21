{ helpers, ... }: {
  imports = helpers.getScopedSubmodules ../apps "nixos";
}
