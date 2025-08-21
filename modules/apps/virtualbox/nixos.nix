{ config, lib, helpers, ... }:

let
  cfg = config.zen.apps.virtualbox;

in {
  imports = [];
  options.zen.apps.virtualbox = {
    enable = helpers.mkBooleanOption false "Whether to enable the VirtualBox virtualization software";
  };
  config = lib.mkIf (cfg.enable) {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  };
}
