{
  description = "Go development environment (go + gopls + delve + golangci-lint)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      devShells = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          default = pkgs.mkShell {
            name = "go-dev";
            packages = with pkgs; [
              go
              gopls
              delve
              golangci-lint
              go-tools
              gotools
              gnumake
              git
              pkg-config
              openssl
            ];

            shellHook = ''
              export GOPATH="$HOME/go"
              export PATH="$GOPATH/bin:$PATH"
            '';
          };
        });
    };
}
