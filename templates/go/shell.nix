{
  pkgs ? import <nixpkgs> {
    system = "x86_64-linux";
    config.allowUnfree = true;
  },
}:

pkgs.mkShell {
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
}
