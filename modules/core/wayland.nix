{ inputs, pkgs, lib, ... }:
{
  # programs.hyprland.enable = true;
  programs.niri.enable =  true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # xdgOpenUsePortal = true;
    extraPortals = [
      # pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal 
      # pkgs.xdg-desktop-portal-wlr
    ];

    config = {
      # common.default = [ "gnome" "gtk" ]; 
      common.default = [ "wlr" "gtk" ];
    };
  };


  environment.systemPackages = with pkgs; [
    gnome-keyring
    xwayland-satellite
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
