{
  pkgs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Nix language tooling.
      nixfmt
      nil
      nixd
      statix
      deadnix

      # LSP servers.
      gopls
      rust-analyzer
      clang-tools
      basedpyright

      # Formatters / linters.
      biome
      ruff
      shellcheck
      shfmt
      stylua
    ];
  };

  programs.vscodium = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        arrterian.nix-env-selector
        jdinhlife.gruvbox
      ];
      userSettings = {
        "update.mode" = "none";
        "extensions.autoUpdate" = false;
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "toggle";
        "editor.fontFamily" = "'FiraCode Nerd Font', monospace";
        "editor.fontSize" = 16;
        "workbench.colorTheme" = "Gruvbox Dark Hard";
        "editor.formatOnSave" = true;
        "files.autoSave" = "onWindowChange";
        "editor.fontLigatures" = true;
        "editor.mouseWheelZoom" = true;
        "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
      };
    };
  };

  # micro as a quick non-modal fallback editor (set as `nano` alias in shell).
  programs.micro = {
    enable = true;
    settings = {
      colorscheme = "gruvbox";
      tabstospaces = true;
      tabsize = 4;
      mkparents = true;
    };
  };
}
