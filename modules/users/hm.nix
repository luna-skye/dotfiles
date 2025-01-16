{ config, lib, helpers, ... }: {
  imports = [];


  options.bead.user = {
    name = helpers.mkStringOption "username" "The string name of the home-manager user";
    isNormalUser = helpers.mkBooleanOption true "Whether this user should be registered as a normal user on the NixOS system level";
    extraGroups = helpers.mkListOfOption lib.types.str [ "network-manager" "wheel" ] "User groups to add this user to on the NixOS system level";

    dirs = lib.mkOption {
      description = lib.mdDoc ''Sets the XDG Home directories for a user'';
      type = lib.types.attrs;
      default = {
        desktop     = "$HOME/Desktop";
        documents   = "$HOME/Documents";
        download    = "$HOME/Downloads";
        music       = "$HOME/Music";
        pictures    = "$HOME/Pictures";
        publicShare = "$HOME/Public";
        templates   = "$HOME/Templates";
        videos      = "$HOME/Videos";
      };
    };
  };


  config = {
    home.username = lib.mkDefault config.bead.user.name;
    home.homeDirectory = lib.mkDefault "/home/${config.bead.user.name}";

    # automatically enable user dirs and merge with bead config option
    xdg.userDirs = { enable = true; } // config.bead.user.dirs;
  };
}
