{ helpers, ... }: {
  imports = helpers.getScopedSubmodules ../shell "nixos";
}
