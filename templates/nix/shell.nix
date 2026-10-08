{
  pkgs ? import <nixpkgs> {
    system = "x86_64-linux";
    config.allowUnfree = true;
  },
}:

pkgs.mkShell {
  name = "nix-dev";

  packages = with pkgs; [
    # Formatting and linting.
    nixfmt-rfc-style
    nixd
    nil
    statix
    deadnix

    # Tools.
    nix-output-monitor
    nvd
    nh
    git

    # LSP clients (for editor integration).
    nixd
  ];

  shellHook = ''
    export NIX_CONFIG="experimental-features = nix-command flakes"
  '';
}
