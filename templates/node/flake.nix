{
  description = "Node.js / TypeScript development environment (pnpm + biome + deno + vite)";

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
            name = "node-dev";
            packages = with pkgs; [
              nodejs_22
              pnpm
              typescript
              biome
              deno
              vite

              git
              gnumake
              shellcheck
              shfmt
              editorconfig-checker
            ];

            shellHook = ''
              export NODE_OPTIONS="--max-old-space-size=8192"
              if [ -f package.json ]; then
                echo "Node project detected. Run 'pnpm install' to fetch deps."
              fi
            '';
          };
        };
      });
}
