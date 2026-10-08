{
  pkgs,
  config,
  lib,
  ...
}:

{
  # Kernel sysctl tuning — only enable documented safe values.
  boot.kernel.sysctl = {
    # Better desktop responsiveness under memory pressure.
    "vm.swappiness" = 10;
    # Page cache / dirty page tuning for desktops with NVMe storage.
    "vm.dirty_ratio" = 5;
    "vm.dirty_background_ratio" = 2;
  };

  # Intel microcode updates are managed via nixos-hardware's framework module,
  # but we explicitly enable them here for clarity.
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Default kernel modules expected for a Framework laptop.
  boot.kernelModules = [ "kvm-intel" ];

  # Zram swap compression — laptop-friendly alternative to swap-on-disk.
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };
}
