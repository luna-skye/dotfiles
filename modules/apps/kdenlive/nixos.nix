{ helpers, ... }:


{
  options.zen.apps.kdenlive = {
    enable = helpers.mkBooleanOption false "Whether to install the KdenLive video editing software";
  };
}
