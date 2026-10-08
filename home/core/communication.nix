{ pkgs, ... }:

{
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # LocalSend: enabled per-service file transfer.
  services.localsend.enable = true;
}
