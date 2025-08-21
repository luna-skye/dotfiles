{ helpers, ... }: {
  imports = helpers.getScopedSubmodules ../shell "hm";
}
