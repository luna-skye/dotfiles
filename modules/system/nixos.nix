{ helpers, ... }:

{
  imports = helpers.getScopedSubmodules ../system "nixos";
}
