# 💽 Applications
This module is responsible for all GUI-based application configurations, each with their own sub-module to house options and config.

More info on each application can be found in their respective sub-module's directory, in the `README.md`.


## Default Apps (Home-Manager)
Using Home-Manager options, each user can configure their own default applications for various file/mime types, these default to empty lists, so it's heavily encouraged to set them.

The available types are `browser` for a large variety of url-based types, `audio`, `video`, and `image`. They can be set from the Home-Manager user file with the `zen.apps.default.${type}` options, as a list of application names.

For example:
```nix
zen.apps.default = {
  browser = [ "firefox" ];
  audio = [ "vlc" ];
  video = [ "vlc" ];
  image = [ "oculante" ];
};
```
