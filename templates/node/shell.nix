{
  pkgs ? import <nixpkgs> {
    system = "x86_64-linux";
    config.allowUnfree = true;
  },
}:

pkgs.mkShell {
  name = "node-dev";

  packages = with pkgs; [
    nodejs_22
    pnpm
    typescript
    biome
    deno
    nodePackages_latest.vite

    # Build tools.
    git
    gnumake

    # Linters.
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
}
