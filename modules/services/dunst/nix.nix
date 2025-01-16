{ config, lib, helpers, ... }: let
  cfg = config.bead.services.dunst;
in {
  imports = [];


  options.bead.services.dunst = {
    anchor = helpers.mkStringOption "top-right" "Anchor point for Dunst notifications";
    monitorIdx = helpers.mkStringOption "1" "The index (1 based) of the monitor to display Dunst notifications on";
  };


  config = {};
}
