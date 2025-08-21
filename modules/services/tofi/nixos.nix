{ helpers, ... }:

{
  options.zen.services.tofi = {
    enable = helpers.mkBooleanOption false "Whether to enable the Tofi dmenu application";
  };
}
