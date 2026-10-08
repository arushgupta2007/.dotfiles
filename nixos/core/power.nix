{ pkgs, config, lib, ... }:

{
  # Power management for the Framework Laptop. The bulk of the
  # firmware / sleep tuning comes from nixos-hardware/framework-11th-gen-intel,
  # which is imported from hardware-configuration.nix. We layer a few
  # safe overrides here.
  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
    tlp.enable = lib.mkForce false; # power-profiles-daemon is preferred
  };

  # Suspend-then-hibernate after 30 minutes of inactivity.
  services.logind = {
    settings = {
      Login = {
        HandlePowerKey = "ignore";
        HandleSuspendKey = "suspend";
        HandleHibernateKey = "hibernate";
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
      };
      Sleep = {
        # Suspend then hibernate after 30 min to save battery.
        HybridSleepMode = "suspend-then-hibernate";
        SuspendThenHibernateDelaySec = "30min";
      };
    };
  };

  # powerManagement.cpuFreqGovernor is set by the host configuration.
}
