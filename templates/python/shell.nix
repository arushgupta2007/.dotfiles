{
  pkgs ? import <nixpkgs> {
    system = "x86_64-linux";
    config.allowUnfree = true;
  },
}:

pkgs.mkShell {
  name = "python-dev";

  packages = with pkgs; [
    # Python with uv for dependency management.
    uv
    python313

    # Python tooling.
    ruff
    basedpyright
    pytest
    pytest-cov
    ipython
    black
    isort
    mypy
    pipx

    # Common scientific Python packages.
    numpy
    pandas
    matplotlib
    scipy
    requests

    # Project utilities.
    git
    gnumake
    pre-commit

    # Linters and formatters.
    shellcheck
    shfmt
    editorconfig-checker
  ];

  shellHook = ''
    export PYTHONDONTWRITEBYTECODE=1
    export PYTHONUNBUFFERED=1
    if [ -f .venv/bin/activate ]; then
      source .venv/bin/activate
    fi
  '';
}
