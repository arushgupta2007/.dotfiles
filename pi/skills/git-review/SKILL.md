---
name: git-review
description: Review staged or unstaged git changes. Use when asked to "review", "audit", or "check" changes before committing.
---

# Git Review Workflow

Use `git diff` (or `lazygit`) to inspect changes before recommending
commits. The user prefers:

- Commit messages in the imperative mood.
- A subject line under 72 chars.
- A blank line, then a body explaining the "why".

## Steps

1. `git status` — confirm what is changing.
2. `git diff` — review the diff line-by-line. Look for:
   - Leftover debugging code.
   - Hard-coded credentials.
   - Filesystem paths or UUIDs that should not have changed.
   - Missing tests.
3. Suggest a commit message only after the diff looks clean.

## Useful tools

- `lazygit` — interactive TUI.
- `delta` — readable git diffs.
- `git log -p -1` — see the previous commit's diff for context.
