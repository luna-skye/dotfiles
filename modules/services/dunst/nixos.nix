{ helpers, ... }:


{
  imports = [];
  options.zen.services.dunst = {
    enable = helpers.mkBooleanOption false "Whether to install the Dunst notification daemon";
  };
  config = {};
}
