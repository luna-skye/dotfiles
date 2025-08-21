{ helpers, ... }:

{
  imports = [];
  options.zen.services.swww = {
    enable = helpers.mkBooleanOption false "Whether to enable the SWWW wallpaper daemon service";
  };
  config = {};
}
