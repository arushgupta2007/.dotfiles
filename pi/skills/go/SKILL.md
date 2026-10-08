---
name: go-dev
description: Go development with gopls and Delve. Use when scaffolding, reviewing, or debugging Go code.
---

# Go Development

The user uses the official Go toolchain, `gopls` for LSP, `golangci-lint`
for combined linting, and `delve` for debugging.

## Common commands

```bash
go mod init <module>
go get <pkg>
go mod tidy
go build ./...
go test ./...
golangci-lint run
```

## Style

- Follow `gofmt` and `goimports`.
- Errors returned, not panicked.
- Internal packages named `internal/<thing>`.
- Tests: standard `testing` package unless there's a project-specific
  framework.

## Layout

```
myapp/
├── cmd/myapp/main.go
├── internal/<package>/...
├── pkg/<package>/...   # public
├── go.mod
└── go.sum
```
