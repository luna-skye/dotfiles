{ bead, ... }: {
  imports = bead.getScopedSubmodules ../apps "nix";
}
