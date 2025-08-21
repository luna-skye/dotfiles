{ helpers, ... }:

{
  options.zen.apps.feishin = {
    enable = helpers.mkBooleanOption false "Whether to install the Feishin desktop for Navidrome";
  };
}
