# Hardware configuration for the Framework Laptop 11th Gen Intel.
#
# Preserved verbatim from the previous NixOS configuration. UUIDs and LUKS
# mappings MUST NOT be changed without an explicit migration step.
{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f340430e-65df-4f77-b3d2-6f677803c6b2";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-140a74ca-9420-41c4-b4a9-1e4b716141c4".device =
    "/dev/disk/by-uuid/140a74ca-9420-41c4-b4a9-1e4b716141c4";
  boot.initrd.luks.devices."luks-1973fde1-9894-4543-9aed-5b35a27d6c6c".device =
    "/dev/disk/by-uuid/1973fde1-9894-4543-9aed-5b35a27d6c6c";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B678-E4D3";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/5c23159a-724c-45ae-992e-6bbd69de9572"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
