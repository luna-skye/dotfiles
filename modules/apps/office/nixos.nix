{ helpers, ... }:

{
  options.zen.apps.office = {
    enable = helpers.mkBooleanOption false "Whether to enable the Libre Office suite";
  };
}
