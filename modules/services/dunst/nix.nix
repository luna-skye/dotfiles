{ config, lib, bead, ... }: let
  cfg = config.bead.services.dunst;
in {
  imports = [];


  options.bead.services.dunst = {
    anchor = bead.mkStringOption "top-right" "Anchor point for Dunst notifications";
    monitorIdx = bead.mkStringOption "1" "The index (1 based) of the monitor to display Dunst notifications on";
  };


  config = {};
}
