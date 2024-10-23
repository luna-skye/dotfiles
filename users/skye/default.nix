{ ... }: {
  imports = [];

  bead = {
    stellix = {
      enable = true;
      autoTarget = true;
    };

    apps = {
      default = {
        browser = [ "floorp" ];
        audio = [ "vlc.desktop" ];
        video = [ "vlc.desktop" ];
        image = [ "oculante.desktop" ];
      };

      terminal.kitty.enable = true;

      browser.floorp.enable = true;
      gaming.enable = true;

      anki.enable = true;
      daw.enable = true;
      blender.enable = true;
      godot.enable = true;

      media = {
        audio.tenacity.enable = true;

        video.vlc.enable = true;
        video.obs.enable = true;

        image.oculante.enable = true;
        image.komikku.enable = true;
      };
    };

    cli.git = {
      username = "Luna Skye";
      email = "sepshuncontact@gmail.com";
    };
    networking.ssh.enable = true;


    #  WARN: Avoid changing these after first build and initial setup.
    #  Make sure you know what to do in case of issue, check the `users` home module documentation.
    user = {
      name = "skye";
      isNormalUser = true;
      extraGroups = [ "network-manager" "wheel" ];

      dirs = {
        desktop     = "$HOME/desk";
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
