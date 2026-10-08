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

  # Lid-switch / power-key behaviour.
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleSuspendKey = "suspend";
    HandleHibernateKey = "hibernate";
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore";
  };

  # powerManagement.cpuFreqGovernor is set by the host configuration.
}
