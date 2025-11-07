{ helpers, ... }:

{
  options.zen.apps.idea = {
    enable = helpers.mkBooleanOption false "Whether to enable and install the IntelliJ Idea IDE";
  };
}
