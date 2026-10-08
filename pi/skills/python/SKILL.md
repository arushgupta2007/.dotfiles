---
name: python-dev
description: Python development with uv, Ruff, basedpyright, and pytest. Use when scaffolding, refactoring, or reviewing Python code.
---

# Python Development

The user prefers `uv` for dependency management, `ruff` for formatting and
linting, `basedpyright` for type checking, and `pytest` for tests.

## Project layout

- `pyproject.toml` is the source of truth for dependencies and tool config.
- `uv.lock` is committed.
- Virtual environments live in `.venv/`.

## Common commands

```bash
uv init                # scaffold a new project
uv add <package>       # add a runtime dep
uv add --dev <package> # add a dev dep
uv run <cmd>           # run inside the venv
uv sync                # sync the venv with the lockfile
uv lock --upgrade      # refresh the lockfile
```

## Lint / format / typecheck

```bash
ruff format .
ruff check . --fix
basedpyright .
pytest
```

## Style

- Target Python 3.13 unless the project says otherwise.
- Use type hints everywhere they are not obvious.
- Prefer f-strings, pathlib, and structural pattern matching.
- Tests live next to the code (`tests/` directory or `*_test.py` siblings).
