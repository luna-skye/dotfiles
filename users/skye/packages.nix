{ pkgs, ... }:

{
  home.packages = builtins.attrValues { inherit (pkgs)
    figma-linux
    inkscape
    imagemagick
    aseprite
    blockbench

    cava
    zenity
    v4l-utils
    waifu2x-converter-cpp
    ;
  };
}
