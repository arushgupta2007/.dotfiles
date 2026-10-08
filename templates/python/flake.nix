{
  description = "Python development environment (uv + ruff + basedpyright + pytest)";

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
          py = pkgs.python313.withPackages (p: with p; [
            requests
            numpy
            pandas
            matplotlib
            scipy
            ruff
            pytest
            pytest-cov
            ipython
            black
            isort
            mypy
            pipx
          ]);
        in
        {
          default = pkgs.mkShell {
            name = "python-dev";
            packages = [
              pkgs.uv
              py
              pkgs.basedpyright
            ];

            shellHook = ''
              export PYTHONDONTWRITEBYTECODE=1
              export PYTHONUNBUFFERED=1
              if [ -f .venv/bin/activate ]; then
                source .venv/bin/activate
              fi
            '';
          };
        });
    };
}
