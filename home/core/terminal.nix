{ pkgs, ... }:

{
  # Ghostty — primary terminal emulator. Theme follows DMS Material
  # generated palette; config below uses Gruvbox as a placeholder until
  # DMS-generated colors land in `xdg.configFile."ghostty/themes"`.
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      theme = "GruvboxMaterial-Dark";
      font-family = "FiraCode Nerd Font";
      font-size = 13;
      window-padding-x = 10;
      window-padding-y = 10;
      background-opacity = 0.95;
      confirm-close-window = false;
      clipboard-paste-protection = false;
      mouse-hide-while-typed = true;
      scrollback-limit = 10000;
      command = "zsh";
    };
  };

  # Multiplexer available when desired.
  programs.zellij.enable = true;

  # Common TUI / CLI utilities.
  home.packages = with pkgs; [
    # Core replacements.
    eza
    bat
    ripgrep
    fd

    # System monitors / utilities.
    btop
    btrfs-du
    duf
    dust
    ncdu
    man-pages

    # Git tooling.
    delta
    lazygit

    # Other utilities.
    just
    hyperfine
    tealdeer
    jq
    yq
    yazi
    ffmpeg
    file
    hexdump
    imagemagick
    gifsicle
    onefetch
    wl-clipboard
    wget
    xdg-utils
    unzip
    p7zip
    unrar
    mpv
    yt-dlp
    xxd
    openssl

    # Productivity / fun.
    todo
    toipe
    ttyper
    pamixer
    playerctl
    gtrash
    brightnessctl
    networkmanagerapplet
    blueman
    pwvucontrol

    # GUI utilities.
    gnome-calculator
    gimp
    gnome-text-editor
    file-roller
    evince
    zathura
    libreoffice
    audacity
    qalculate-gtk
    dbeaver-bin
    vesktop
    signal-desktop
    scrcpy
    soundwireserver
    swappy
    wayscriber
    zenity
    wl-mirror

    # Fetch / system info.
    fastfetch
    fzf
  ];
}
