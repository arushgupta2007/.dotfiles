{
  pkgs,
  ...
}:

{
  # System fonts.
  fonts.fontconfig.enable = true;

  # GTK theme: Material-style via Gruvbox.
  gtk = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme.override {
        colorVariants = [ "dark" ];
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "black";
      };
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # Qt theme.
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "breeze";
    };
  };

  # Bat config.
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "gruvbox-dark";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
      batgrep
    ];
  };

  # Btop config.
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      update_ms = 500;
    };
  };

  home.packages = with pkgs; [
    # Fonts.
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    twemoji-color-font
    noto-fonts-color-emoji
    google-fonts

    # Qt config tool.
    kdePackages.qt6ct

    # nvtop for Intel GPU monitoring.
    nvtopPackages.intel
  ];

  # Mime associations: Brave is the default browser; VLC for video; Nautilus
  # for directories.
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps.enable = true;

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "brave-browser.desktop" ];
    "x-scheme-handler/http" = [ "brave-browser.desktop" ];
    "x-scheme-handler/https" = [ "brave-browser.desktop" ];
    "inode/directory" = [ "nautilus.desktop" ];
    "application/pdf" = [ "org.gnome.Papers.desktop" ];
    "video/mp4" = [ "mpv.desktop" ];
    "video/webm" = [ "mpv.desktop" ];
    "application/zip" = [ "org.gnome.FileRoller.desktop" ];
  };
}
