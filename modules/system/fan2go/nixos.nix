{ config, helpers, pkgs, lib, ... }:


let
  cfg = config.zen.system.fan2go;

in {
  options.zen.system.fan2go = {
    enable = helpers.mkBooleanOption false "Whether to enable the fan2go fan controlling daemon";
    autostart = helpers.mkBooleanOption true "Whether to initialize the fan2go daemon on system startup";
    settings = lib.mkOption {
      description = ''
        Fan2Go configuration to write to /etc/fan2go.yaml
        https://github.com/markusressel/fan2go?tab=readme-ov-file#configuration
      '';
      type = lib.types.attrs;
      default = {};
    };
  };

  config = lib.mkIf (cfg.enable && cfg.autostart) {
    systemd.services.fan2go = {
      description = "fan2go fan controller";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.fan2go}/bin/fan2go -v";
        Restart = "always";
        User = "root";
      };
    };

    environment.etc."fan2go/fan2go.yaml".text = lib.generators.toYAML {} ({ api.enabled = true; } // cfg.settings);
  };
}
