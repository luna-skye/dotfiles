{ helpers, ... }:

{
  imports = [];
  options.zen.apps.discord = {
    enable = helpers.mkBooleanOption false "Whether to install the Discord app";
  };
  config = {};
}
