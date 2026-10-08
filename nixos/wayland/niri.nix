{ pkgs, ... }:

{
  # Niri is the only window manager/compositor installed.
  programs.niri.enable = true;

  # libinput handling for touchpad/mouse.
  services.libinput.enable = true;

  # Default user session: Niri (via gnome-session-style alternatives so
  # `update-alternatives --set x-session ...` works correctly).
  services.displayManager = {
    defaultSession = "niri";
    autoLogin.enable = false; # Use DMS greeter instead.
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite # XWayland forwarding over loopback
    grim # screenshots
    slurp # region selection
    wl-clipboard # clipboard utilities (wl-copy, wl-paste)
    wl-clip-persist # persistent clipboard
    mako # notification daemon fallback
    swayidle # idle management
    swaylock # screen lock (DMS uses its own)
    polkit_gnome # polkit agent
    playerctl # MPRIS media controls
  ];
}
