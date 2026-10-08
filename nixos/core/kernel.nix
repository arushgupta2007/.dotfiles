{
  pkgs,
  config,
  lib,
  ...
}:

{
  # Intel microcode updates are managed via nixos-hardware's framework
  # module, but we explicitly enable them here for clarity.
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # zram swap compression. 25 % of 16 GiB ≈ 4 GiB — enough to ride
  # out transient pressure without starving user applications.
  # The NixOS module already enables a sensible zstd algorithm by
  # default on recent releases; we only override the size.
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  # Default kernel modules expected for a Framework laptop.
  # `kvm-intel` is also listed in the host config and the framework
  # nixos-hardware module — definitions merge cleanly.
  boot.kernelModules = [ "kvm-intel" ];
}
