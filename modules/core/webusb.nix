{ pkgs, inputs, username, host, lib, ...}:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", MODE="0664", GROUP="plugdev"
  '';

  users.groups.plugdev = {};
  users.users.${username} = {
    extraGroups = [ "plugdev" ];
  };

  services.udev.packages = [ pkgs.openocd ];
}

