{ helpers, ... }:

{
  options.zen.apps.media = {
    enable = helpers.mkBooleanOption true "Whether to enable ANY media player applications";
    image = {
      gwenview.enable = helpers.mkBooleanOption false "Whether to enable the KDE Gwenview image viewer";
      oculante.enable = helpers.mkBooleanOption false "Whether to enable the Oculante image viewer";
    };
    video = {
      vlc.enable = helpers.mkBooleanOption false "Whether to enable the VLC multimedia player";
      mpv.enable = helpers.mkBooleanOption false "Whether to enable the MPV video player";
    };
    audio = {
      elisa.enable = helpers.mkBooleanOption false "Whether to enable the KDE Elisa audio player";
    };
  };
}
