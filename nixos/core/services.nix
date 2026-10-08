{ ... }:

{
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true; # Weekly TRIM for NVMe
  };

  # Stop shutdown cleanly.
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}
