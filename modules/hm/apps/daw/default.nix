#  TODO: Find way to disable .desktop file outputs for plugins, namely lsp-plugins, should be easy with an override
{ config, lib, bead, pkgs, ... }: let
  defaultPlugins = builtins.attrValues { inherit (pkgs)
    vital             # best synth <3
    cardinal          # vcv rack emulator
    aether-lv2        # reverb
    mda_lv2           # mda port collection
    lsp-plugins       # big collection of everything you could need
    gxplugins-lv2     # guitarix port collection
    eq10q             # equalizers

    distrho           # tons of lv2 ports
    rkrlv2            # rakarrak effects
    bolliedelayxt-lv2 # delay
    airwindows-lv2    # airwindows lv2 port collection
    swh_lv2           # steve harris' SWH plugin port collection
    x42-plugins       # robin gareus' lv2 collection
    bchoppr           # chop chop
    fverb             # stereo reverb from jon dattorro
    boops             # glitchiness
    speech-denoiser   # denoiser based on RNNoise lib
    zam-plugins       # plugins from ZamAudio
    vocproc           # vocal processing
    mod-arpeggiator-lv2

    #  TODO: figure out how to reference pkgs like this one
    # "magnetophonDSP.CharacterCompressor" # compressor
    ;
  };
in {
  imports = [];


  options.bead.apps.daw = {
    enable = bead.mkBooleanOption false "Whether to enable any of the audio workstation module";

    enableDefaultPlugins = bead.mkBooleanOption true "Whether to enable preconfigured LV2/VST plugins";
    plugins = bead.mkListOfOption lib.types.package [] "List of packages to install alongside Ardour as audio plugins";

    ardour = {
      enable = bead.mkBooleanOption false "Whether to enable the Ardour audio workstation software";
    };
  };


  config = lib.mkIf (config.bead.apps.daw.enable) {
    home.packages = let
      inherit (lib.lists) optionals;
    in
      optionals (config.bead.apps.daw.ardour.enable)        [ pkgs.ardour ] ++
      optionals (config.bead.apps.daw.enableDefaultPlugins) defaultPlugins  ++
      config.bead.apps.daw.plugins;
  };
}
