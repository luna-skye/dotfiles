{ helpers, ... }:

{
  options.zen.apps.mumble = {
    enable = helpers.mkBooleanOption false "Whether to install the Mumble client application";
  };
}
