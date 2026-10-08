{
  description = "Nix development environment (nixfmt + nixd + statix + deadnix + nh)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.${system} = {
          default = pkgs.mkShell {
            name = "nix-dev";
            packages = with pkgs; [
              nixfmt
              nixd
              nil
              statix
              deadnix

              nix-output-monitor
              nvd
              nh
              git
            ];

            shellHook = ''
              export NIX_CONFIG="experimental-features = nix-command flakes"
            '';
          };
        };
      });
}
