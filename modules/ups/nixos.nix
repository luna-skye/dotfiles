{ pkgs, lib, helpers, config, ... }:


let
  cfg = config.zen.ups;
  shutdownScript = pkgs.writeShellScript "ups-low-battery-check" ''
    set -eu
    battery_level=$(${pkgs.nut}/bin/upsc cyberpower@localhost battery.charge || echo 100)
    status=$(${pkgs.nut}/bin/upsc cyberpower@localhost ups.status || echo "UNKNOWN")

    if echo "$status" | grep -q "OB"; then
      ${pkgs.util-linux}/bin/logger -t UPS "Battery at $battery_level% and discharging."
      if [ "$battery_level" -le ${toString cfg.autoShutdown.lowPercentage} ]; then
        ${pkgs.util-linux}/bin/logger -t UPS "Battery at $battery_level% and discharging. Initiating shutdown."
        ${pkgs.systemd}/bin/shutdown -h now "UPS battery low"
      fi
    fi
  '';

in {
  options.zen.ups = {
    enable = helpers.mkBooleanOption false "Whether to enable UPS power management services";
    autoShutdown = {
      enable = helpers.mkBooleanOption true "Whether to automatically shutdown when UPS hits low percentage";
      lowPercentage = helpers.mkNumberOption 30 "The battery percentage to automatically shutdown if below";
    };
  };

  config = lib.mkIf (cfg.enable) {
    systemd = lib.mkIf (cfg.autoShutdown.enable) {
      services.ups-low-battery-check = {
        description = "Shutdown system if UPS battery is low";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${shutdownScript}";
        };
      };
      timers.ups-low-battery-check = {
        description = "Timer to periodically check UPS battery level";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "2min";
          OnUnitActiveSec = "1min";
          Unit = "ups-low-battery-check.service";
        };
      };
    };

    power.ups = {
      enable = true;
      mode = "standalone";

      ups.cyberpower = {
        description = "Cyberpower UPS";
        driver = "usbhid-ups";
        port = "auto";
      };
      users = {
        monuser = {
          passwordFile = "/etc/nut-monuser.pass";
          upsmon = "primary";
        };
      };
      upsmon = {
        monitor.cyberpower = {
          user = "monuser";
          passwordFile = "/etc/nut-mon-user.pass";
        };
      };
    };

    sops.secrets.nut-monuser = {
      sopsFile = ./secrets.yaml;
      owner = "monuser";
      group = "monuser";
      mode = "0440";
    };
    environment.etc."nut-monuser.pass".source = config.sops.secrets.nut-monuser.path;

    users.users.monuser = {
      description = "UPS Monitor User";
      isSystemUser = true;
      group = "monuser";
    };
    users.groups.monuser = {};
  };
}
