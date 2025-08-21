{ helpers, ... }:

{
  imports = [];
  options.zen.apps.anki = {
    enable = helpers.mkBooleanOption false "Whether to install the Anki SRS application";
  };
  config = {};
}
