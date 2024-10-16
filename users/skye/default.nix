{ ... }: {
  imports = [];

  bead = {
    ssh.enable = true;

    stellix.enable = true;
    hyprland.enable = true;
    apps = {
      terminal.kitty.enable = true;

      daw.enable = true;
      blender.enable = true;
      godot.enable = true;

      gaming.enable = true;
    };


    #  WARN: Avoid changing these after first build and initial setup.
    #  Make sure you know what to do in case of issue, check the `users` home module documentation.
    user = {
      name = "skye";
      isNormalUser = true;
      extraGroups = [ "network-manager" "wheel" ];

      dirs = {
        desktop     = "$HOME/desktop";
        documents   = "$HOME/docs";
        download    = "$HOME/dl";
        music       = "$HOME/music";
        pictures    = "$HOME/pics";
        publicShare = "$HOME/public";
        templates   = "$HOME/templates";
        videos      = "$HOME/vids";
      };
    };
  };
}
