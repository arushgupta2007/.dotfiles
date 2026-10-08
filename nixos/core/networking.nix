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
      allowedTCPPorts = [ 22 80 443 ];
      allowedUDPPorts = [ ];
    };
    nameservers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  # Resolve mDNS for local services (KDE Connect, LocalSend, printers).
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
