{ helpers, ... }:

{
  options.zen.cli.imagemagick = {
    enable = helpers.mkBooleanOption false "Whether to install the Imagemagick image processing cli tool";
  };
}
