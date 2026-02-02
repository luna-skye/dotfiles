{ config, helpers, ... }:

let
  cfg = config.zen.services.noctalia-shell;

in {
  options.zen.services.noctalia-shell = {
    enable = helpers.mkBooleanOption false "Whether to enable the Noctalia Shell";
  };
}
