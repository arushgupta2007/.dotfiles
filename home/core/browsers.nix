{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--enable-features=TouchpadOverscrollHistoryNavigation"
      "--enable-features=VaapiVideoDecoder"
      "--disable-features=UseChromeOSDirectVideoDecoder"
    ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # Enhancer for YouTube
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
    ];
  };

  # Firefox for cross-browser testing.
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      extraPolicies = {
        AutoSelectDisableForPDF = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
        };
      };
    };
  };
}
