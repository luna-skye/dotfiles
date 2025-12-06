{ helpers, ... }:


{
  options.zen.apps.chromium = {
    enable = helpers.mkBooleanOption false "Whether to install the Chromium browser";
  };
}
