{ pkgs, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      # WiFi powersave: modest battery savings on laptops.
      wifi.powersave = true;
    };

    firewall = {
      enable = true;
      # Inbound ports are closed by default. The host config opens
      # specific ranges for KDE Connect; SSH and web services must be
      # opted into explicitly when needed.
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };

    # DNS: defer to NetworkManager + DHCP. Hardcoding public DNS can
    # slow down initial lookups and breaks split-horizon DNS on some
    # networks. Re-add explicit nameservers here only if DHCP DNS is
    # known to be unreliable on the networks you use.
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  # mDNS for local services (KDE Connect, LocalSend, printers, etc.).
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
