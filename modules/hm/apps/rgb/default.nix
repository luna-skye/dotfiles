{ config, lib, bead, ... }: {
  imports = [];


  options.bead.apps.rgb = {
    enable = bead.mkBooleanOption false "Whether to enable the OpenRGB application";
  };


  config = {};
}
