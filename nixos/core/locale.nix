{ pkgs, ... }:

{
  # Time and locale — preserve Asia/Kolkata from the existing setup.
  time.timeZone = "Asia/Kolkata";

  i18n = {
    defaultLocale = "en_IN.UTF-8";

    # Locales compiled into the system locale archive. Use `extraLocales`
    # (replaces the deprecated `supportedLocales`).
    extraLocales = [
      "en_IN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  # Allow unfree packages (Brave, codecs, etc.).
  nixpkgs.config.allowUnfree = true;
}
