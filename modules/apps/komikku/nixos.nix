{ helpers, ... }:

{
  imports = [];
  options.zen.apps.komikku = {
    enable = helpers.mkBooleanOption false "Whether to install the Komikku manga reader";
  };
  config = {};
}

