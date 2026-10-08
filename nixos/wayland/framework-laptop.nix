{ pkgs, ... }:

{
  # Battery charge limit. Framework laptops with the embedded controller
  # driver expose charge_control_end_threshold and charge_control_start_threshold
  # under /sys/class/power_supply/BAT0/. Stop at 80% / restart at 75%
  # to extend battery lifespan.
  systemd.services.framework-charge-limit = {
    description = "Set Framework laptop battery charge thresholds";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysfs.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "set-charge-limit" ''
        #!/usr/bin/env bash
        set -euo pipefail
        if [ -f /sys/class/power_supply/BAT0/charge_control_end_threshold ]; then
          echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold
          echo 75 > /sys/class/power_supply/BAT0/charge_control_start_threshold
        fi
        if [ -f /sys/class/power_supply/BAT1/charge_control_end_threshold ]; then
          echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold
          echo 75 > /sys/class/power_supply/BAT1/charge_control_start_threshold
        fi
      '';
    };
  };
}
