{ pkgs, ... }: 
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" "--enable-features=TouchpadOverscrollHistoryNavigation" ];
    extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
        { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # Enhancer for Youtube
        # { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Stylus
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton pass
        { id = "gakohpplicjdhhfllilcjpfildodfnnn"; } # Carrot - Codeforces Rating Predictor
    ];
  };
}
