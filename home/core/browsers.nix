{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      # Select Wayland over XWayland for the main window.
      "--ozone-platform=wayland"
      # Comma-separated list of feature flags (avoids the duplicate
      # `--enable-features=` repetition and is the supported syntax).
      "--enable-features=TouchpadOverscrollHistoryNavigation,VaapiVideoDecoder"
      # ChromeOS-specific decoder that we do not want on Linux.
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
