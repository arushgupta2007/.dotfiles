{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    ## CLI utility
    ani-cli
    # aider-chat-full
    bitwise                           # cli tool for bit / hex manipulation
    caligula                          # User-friendly, lightweight TUI for disk imaging
    claude-code
    cliphist                          # clipboard manager
    distrobox
    eza                               # ls replacement
    entr                              # perform action when file change
    fd                                # find replacement
    ffmpeg
    file                              # Show file information 
    gtt                               # google translate TUI
    gifsicle                          # gif utility
    gtrash                            # rm replacement, put deleted files in system trash
    hexdump
    imv                               # image viewer
    jq
    killall
    lazygit
    libnotify
	  man-pages					            	  # extra man pages
    mpv                               # video player
    ncdu                              # disk space
    nitch                             # systhem fetch util
    openssl
    onefetch                          # fetch utility for git repo
    pamixer                           # pulseaudio command line mixer
    playerctl                         # controller for media players
    poweralertd
    qview                             # minimal image viewer
    ripgrep                           # grep replacement
    tdf                               # cli pdf viewer
    tldr
    todo                              # cli todo list
    toipe                             # typing test in the terminal
    ttyper                            # cli typing test
    unzip
    valgrind                          # c memory analyzer
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    wget
    yazi                              # terminal file manager
    yt-dlp-light
    xdg-utils
    xxd

    ## CLI 
    cbonsai                           # terminal screensaver
    cmatrix
    conda
    pipes                             # terminal screensaver
    sl
    tty-clock                         # cli clock
    brightnessctl
    podman-tui
    podman-compose
    openfortivpn
    flutter
    jdk25_headless
    pi-coding-agent

    android-studio
    android-tools

    ## GUI Apps
    audacity
    bleachbit                         # cache cleaner
    blueman
    bottles-unwrapped
    dbeaver-bin
    evince
    gimp
    hoppscotch
    kdePackages.okular
    libreoffice
    nix-prefetch-github
    nwg-displays
    nwg-look
    openfortivpn-webview
    # masterpdfeditor
    # pavucontrol                       # pulseaudio volume controle (GUI)
    pwvucontrol
    playonlinux
    proton-vpn                     # ProtonVPN
    qalculate-gtk                     # calculator
    signal-desktop
    soundwireserver                   # pass audio to android phone
    swappy
    scrcpy
    ungoogled-chromium
    vlc
    vesktop
    wayscriber
    wdisplays
    # winetricks
    # wineWowPackages.wayland
    wl-mirror
    zathura
    zenity

    inputs.alejandra.defaultPackage.${stdenv.hostPlatform.system}
  ]);  
}
