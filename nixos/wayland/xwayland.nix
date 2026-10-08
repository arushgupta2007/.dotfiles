{ ... }:

{
  # XWayland is enabled through xwayland-satellite in the niri module. We
  # disable the legacy X server entirely.
  services.xserver.enable = false;

  # Make sure GPU drivers for Intel iGPU are loaded.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
