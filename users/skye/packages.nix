{ pkgs, ... }:

{
  home.packages = builtins.attrValues { inherit (pkgs)
    zenity
    v4l-utils
    waifu2x-converter-cpp
    ;
  };
}
