{ helpers, ... }:

{
  imports = [];
  options.zen.apps.signal = {
    enable = helpers.mkBooleanOption false "Whether to install the Signal messaging app";
  };
  config = {};
}

