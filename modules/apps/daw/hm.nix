{ osConfig, pkgs, lib, ... }:

let
  hostCfg = osConfig.zen.apps.daw;
in {
  options.zen.apps.daw = {};

  config = lib.mkIf (hostCfg.enable) {
    home.sessionVariables = {
      DSSI_PATH   = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/etc/profiles/per-user/skye/lib/dssi";
      LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/etc/profiles/per-user/skye/lib/ladspa";
      LV2_PATH    = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/etc/profiles/per-user/skye/lib/lv2";
      LXVST_PATH  = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/etc/profiles/per-user/skye/lib/lxvst";
      VST_PATH    = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/etc/profiles/per-user/skye/lib/vst";
    };

    home.packages = builtins.attrValues { inherit (pkgs)
      wineasio # asio to jack driver for WINE based daws
      qjackctl # jack control panel
      bespokesynth # modular synth fun
      cardinal # vcv rack emulator
      tenacity # audacity, basically
      ardour # best daw?
      vital # best synth <3
      mod-arpeggiator-lv2
      rkrlv2 # rakarrak effects
      bolliedelayxt-lv2 # delay
      airwindows-lv2 # airwindows lv2 port collection
      aether-lv2 # reverb
      swh_lv2 # steve harris' SWH plugin port collection
      mda_lv2 # mda port collection
      x42-plugins # robin gareus' lv2 collection
      bchoppr # chop chop
      gxplugins-lv2 # guitarix port collection
      fverb # stereo reverb from jon dattorro
      boops # glitchiness
      speech-denoiser # denoiser based on RNNoise lib
      eq10q # equalizers
      zam-plugins # plugins from ZamAudio
      vocproc # vocal processing
      lsp-plugins # big collection of everything you could need
      ;
    };
  };
}
