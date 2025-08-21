{ helpers, ... }:

{
  options.zen.apps.isoimagewriter = {
    enable = helpers.mkBooleanOption true "Whether to install the KDE ISO Image Writer";
  };
}
