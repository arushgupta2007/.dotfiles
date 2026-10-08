{
  pkgs,
  lib,
  ...
}:

{
  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = true;
  };

  # Polkit agent via DMS / gnome-shell when available.
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  services.dbus.enable = true;

  # OpenSSH only enabled when explicitly opted in (not by default).
  services.openssh.enable = lib.mkDefault false;

  # Disable unused legacy services.
  services.nscd.enable = lib.mkForce true;
}
