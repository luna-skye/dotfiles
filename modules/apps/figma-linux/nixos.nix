{ helpers, ... }:

{
  options.zen.apps.figma-linux = {
    enable = helpers.mkBooleanOption false "Whether to install the Figma Linux desktop app";
  };
}
