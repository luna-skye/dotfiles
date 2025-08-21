{ helpers, ... }:

{
  imports = [];
  options.zen.apps.bottles = {
    enable = helpers.mkBooleanOption false "Whether to install the Bottles WINE management application";
  };
  config = {};
}
