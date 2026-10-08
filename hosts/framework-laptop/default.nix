{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/core
    ../../nixos/wayland
  ];

  # Host identity
  networking.hostName = "framework-laptop";
  networking.domain = "";

  # Preserve existing state version
  system.stateVersion = "26.11";

  # Bootloader (Framework uses systemd-boot via UEFI).
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # Laptop-specific firmware + power management. The nixos-hardware module
  # covers most of this; we tune a few things here.
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault
    config.hardware.enableRedistributableFirmware;

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    acpi
  ];

  # Power-management for laptops. power-profiles-daemon provides the
  # performance / balanced / power-saver profiles, while TLP-style tuning
  # is handled via nixos-hardware for Framework laptops.
  services.power-profiles-daemon.enable = true;
  services.upower = {
    enable = true;
    percentageLow = 20;
    percentageCritical = 5;
    percentageAction = 3;
    criticalPowerAction = "PowerOff";
  };

  # Firewall — keep closed by default, open KDE Connect ports for phone
  # integration.
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # Kernel module required for Framework laptop power tweaks.
  boot.kernelModules = [ "kvm-intel" ];
}
