{ pkgs, ... }:

{
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # LocalSend is installed via programs.localsend in nixos/core/services.nix
  # (which also opens the firewall port).
}
