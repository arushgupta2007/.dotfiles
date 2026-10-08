{ pkgs, config, ... }:
{
  home.packages = with pkgs; [ 
    kdePackages.qt6ct
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";

    style = {
      name = "breeze";
    };
  };
}

