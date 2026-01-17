{ helpers, ... }:

{
  options.zen.apps.inkscape = {
    enable = helpers.mkBooleanOption false "Whether to install the Inkscape vector software";
  };
}
