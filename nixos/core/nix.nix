{ ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    # Run GC weekly and delete old boot/system entries.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # nix-output-monitor / nvd for human-friendly builds.
  environment.systemPackages = [
    pkgs.nix-output-monitor
    pkgs.nvd
  ];
}
