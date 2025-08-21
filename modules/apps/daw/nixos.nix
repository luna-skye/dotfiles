{ helpers, ... }:

{
  imports = [];
  options.zen.apps.daw = {
    enable = helpers.mkBooleanOption false "Whether to install and configure the audio workstation environment";
  };
  config = {};
}
