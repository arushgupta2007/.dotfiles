{ pkgs, ... }:

{
  # XDG Desktop Portal. Niri's upstream recommendation is
  #   xdg-desktop-portal-gtk      for general file/print/etc
  #   xdg-desktop-portal-gnome    for screencast / Secret portal
  # `xdg-desktop-portal-wlr` is NOT needed for Niri (Niri is not
  # wlroots-based). systemd activates the portals on demand.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "gnome" "gtk" ];
    };
  };

  environment.sessionVariables = {
    # Required for Chromium / Brave / VSCodium native Wayland rendering.
    NIXOS_OZONE_WL = "1";
  };
}
