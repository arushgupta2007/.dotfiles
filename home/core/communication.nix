{ pkgs, ... }:

{
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  home.packages = [ pkgs.localsend ];
}
