---
name: typescript-dev
description: TypeScript / Node.js development with pnpm and Biome. Use when scaffolding, formatting, or debugging JS/TS projects.
---

# TypeScript / Node.js Development

The user prefers `pnpm` for package management, `Biome` for formatting and
linting, and the built-in TypeScript compiler for type checking.

## Project layout

- `package.json` is the source of truth for deps and scripts.
- `pnpm-lock.yaml` is committed.
- `biome.json` configures formatter + linter.

## Common commands

```bash
pnpm init                     # scaffold
pnpm add <pkg>                # add dep
pnpm add -D <pkg>             # add dev dep
pnpm install                  # sync
pnpm run <script>             # run script
pnpm dlx <bin>                # one-shot execution
```

## Lint / format / typecheck

```bash
biome format --write .
biome lint --apply .
pnpm exec tsc --noEmit
```

## Conventions

- Strict TS config (`strict: true`).
- ESM-first. CJS only when interfacing with legacy modules.
- Tests: `vitest` or `node --test`, depending on the project.
- Use `node:` prefix for built-in modules.
