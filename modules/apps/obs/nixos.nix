{ helpers, ... }:

{
  imports = [];
  options.zen.apps.obs = {
    enable = helpers.mkBooleanOption false "Whether to install the OBS-Studio screen recording software";
  };
  config = {};
}
