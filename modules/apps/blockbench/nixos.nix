{ helpers, ... }:

{
  options.zen.apps.blockbench = {
    enable = helpers.mkBooleanOption false "Whether to install the Blockbench 3D software";
  };
}
