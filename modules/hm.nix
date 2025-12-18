{ config, pkgs, lib, helpers, stellae, ... }:


let
  # Convert dotfiles logo to currently configured STELLAE theme
  logo = pkgs.stdenvNoCC.mkDerivation {
    name = "totality-logo";
    src = ../.assets/logo.png;

    nativeBuildInputs = [ pkgs.gowall ];
    dontUnpack = true;
    dontInstall = true;
    buildPhase = /* bash */ ''
      export HOME="$TMPDIR"
      export XDG_CONFIG_HOME="$TMPDIR/.config"

      mkdir -p "$TMPDIR/.config/gowall"
      cat > "$TMPDIR/.config/gowall/config.yml" <<'EOF'
      EnableImagePreviewing: false
      InlineImagePreview: false
      EOF

      mkdir -p $out

      cat > theme.json <<'EOF'
      ${stellae.exporters.gowall.jsonFile { element = config.zen.theme.element; }}
      EOF
      
      gowall convert \
        -t theme.json \
        --output $out/logo.png \
        $src
    '';
  };

in {
  imports = helpers.getScopedSubmodules ../modules "hm";

  config = {
    home.file.".config/totality-nixos/logo.png".source = "${logo}/logo.png";

    #  WARN: DO NOT CHANGE THESE
    home.stateVersion = lib.mkForce "23.11";
    programs.home-manager.enable = lib.mkForce true;
  };
}
