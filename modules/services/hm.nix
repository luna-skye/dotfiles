{ helpers, ... }:

{
  imports = helpers.getScopedSubmodules ../services "hm";
}
