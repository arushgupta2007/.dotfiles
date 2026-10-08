{ pkgs, ... }:

{
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # WirePlumber is the default session manager in modern pipewire.
  };

  security.rtkit.enable = true;
}
