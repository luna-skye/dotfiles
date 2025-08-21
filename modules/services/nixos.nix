{ helpers, ... }:

{
  imports = helpers.getScopedSubmodules ../services "nixos";
}
