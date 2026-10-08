{ ... }:

{
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true; # Weekly TRIM for NVMe
  };

  # LocalSend — file/clipboard sharing over the LAN. The module adds
  # the package AND opens the firewall port (53317 TCP+UDP) for
  # inbound transfers; mDNS discovery is already covered by Avahi.
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # Stop shutdown cleanly.
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}
