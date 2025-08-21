{ helpers, ... }:

{
  options.zen.apps.krita = {
    enable = helpers.mkBooleanOption false "Whether to install the Krita image editor";
  };
}
