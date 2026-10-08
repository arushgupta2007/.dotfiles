{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Show battery charge of connected devices
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
}
