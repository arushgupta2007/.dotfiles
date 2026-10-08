{ pkgs, ... }:

{
  # Time and locale — preserve Asia/Kolkata from the existing setup.
  time.timeZone = "Asia/Kolkata";

  i18n = {
    defaultLocale = "C.UTF-8";

    # Locales compiled into the system locale archive. Use `extraLocales`
    # (replaces the deprecated `supportedLocales`).
    extraLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Allow unfree packages (Brave, codecs, etc.).
  nixpkgs.config.allowUnfree = true;
}
