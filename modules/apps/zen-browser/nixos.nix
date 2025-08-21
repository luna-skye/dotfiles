{ helpers, ... }:

{
  imports = [];
  options.zen.apps.zen-browser = {
    enable = helpers.mkBooleanOption false "Whether to install the Zen Browser";
    disableTelemetry = helpers.mkBooleanOption true "Whether to disable telemetry";
  };
}
