{
  pkgs ? import <nixpkgs> {
    system = "x86_64-linux";
    config.allowUnfree = true;
  },
}:

let
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
pkgs.mkShell {
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
}
