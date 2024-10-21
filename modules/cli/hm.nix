{ bead, ... }: {
  imports = bead.getScopedSubmodules ../cli "hm";
}
