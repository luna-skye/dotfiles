{ helpers, ... }:

{
  options.zen.apps.aseprite = {
    enable = helpers.mkBooleanOption false "Whether to install the Aseprite pixel art editor";
  };
}
