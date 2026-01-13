{ osConfig, pkgs, lib, ... }:


let
  cfg = osConfig.zen.apps.idea;

  idea = pkgs.jetbrains.idea-oss;
  libPath = lib.makeLibraryPath [
    pkgs.glfw
    pkgs.libglvnd
    pkgs.flite
    pkgs.alsa-lib
    pkgs.pulseaudio
    pkgs.pipewire
  ];

in {
  config = lib.mkIf (cfg.enable) {
    home.packages = [ idea ];
    home.file.".local/share/applications/idea-community.desktop".text = ''
      [Desktop Entry]
      Name=IntelliJ IDEA
      GenericName=Java, Kotlin, Groovy and Scala IDEA from Jetbrains
      Exec=env LD_LIBRARY_PATH=${libPath}:$LD_LIBRARY_PATH ${idea}/bin/idea-community
      Icon=idea-community
      Type=Application
      Categories=Development;IDE;
      Terminal=false
      StartupWMClass=jetbrains-idea-ce
    '';
  };
}
