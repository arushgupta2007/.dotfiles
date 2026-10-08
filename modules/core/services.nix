{ ... }: 
{
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    upower.enable = true;
  };
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };
}
