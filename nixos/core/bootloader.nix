{ pkgs, ... }:

{
  # Latest stable kernel with the Framework firmware quirks handled in
  # hardware-configuration.nix.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
