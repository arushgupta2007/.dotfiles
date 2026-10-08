{
  pkgs,
  lib,
  config,
  ...
}:

let
  zshInitFirst = lib.mkOrder 500 ''
    DISABLE_AUTO_UPDATE=true
    DISABLE_MAGIC_FUNCTIONS=true
    export MICRO_TRUECOLOR=1
  '';

  zshInitExtra = lib.mkOrder 1200 ''
    setopt share_history
    setopt hist_expire_dups_first
    setopt hist_ignore_dups
    setopt hist_verify

    # fd-based path completion for fzf
    _fzf_compgen_path() {
      fd --hidden --exclude .git . "$1"
    }
    _fzf_compgen_dir() {
      fd --type=d --hidden --exclude .git . "$1"
    }
    _fzf_comprun() {
      local command=$1
      shift
      case "$command" in
        cd)  fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
        ssh) fzf --preview 'dig {}' "$@" ;;
        *)   fzf --preview "$show_file_or_dir_preview" "$@" ;;
      esac
    }
  '';
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = lib.mkMerge [ zshInitFirst zshInitExtra ];

    profileExtra = ''
      command_not_found_handle() {
        if [ ! -e /run/.containerenv ] && [ ! -e /.dockerenv ]; then
          exit 127
        fi
        distrobox-host-exec "''${@}"
      }
      if [ -n "''${ZSH_VERSION-}" ]; then
        command_not_found_handler() {
          command_not_found_handle "$@"
        }
      fi
    '';

    shellAliases = {
      c = "clear";
      cd = "z";
      tt = "gtrash put";
      cat = "bat";
      nano = "micro";
      code = "codium";
      py = "python";
      icat = "kitten icat";
      dsize = "du -hs";
      pdf = "tdf";
      open = "xdg-open";
      space = "ncdu";
      man = "BAT_THEME=default batman";

      l = "eza --icons -a --group-directories-first -1 --no-user --long";
      ll = "eza --icons -a --group-directories-first -1 --no-user --long";
      tree = "eza --icons --tree --group-directories-first";

      cdnix = "cd ~/.dotfiles && codium ~/.dotfiles";
      ns = "nom-shell --run zsh";
      nix-switch = "nh os switch";
      nix-update = "nh os switch --update";
      nix-clean = "nh clean all --keep 5";
      nix-search = "nh search";
      nix-test = "nh os test";

      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";

      compile = "clang++ -Wall -Wextra -pedantic -std=c++23 -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector";
    };
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    fileWidget = {
      options = [
        "--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'"
      ];
    };
    changeDirWidget = {
      command = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
      options = [
        "--preview 'eza --tree --color=always {} | head -200'"
      ];
    };
    defaultOptions = [
      "--color=fg:-1,fg+:#FBF1C7,bg:-1,bg+:#282828"
      "--color=hl:#98971A,hl+:#B8BB26,info:#928374,marker:#D65D0E"
      "--color=prompt:#CC241D,spinner:#689D6A,pointer:#D65D0E,header:#458588"
      "--color=border:#665C54,label:#aeaeae,query:#FBF1C7"
      "--border='rounded' --border-label='' --preview-window='border-rounded' --prompt='> '"
      "--marker='>' --pointer='>' --separator='─' --scrollbar='│'"
      "--info='right'"
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      palette = "gruvbox_dark";
      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };
    };
  };

  # Searchable shell history (Atuin). Disables Ctrl-R so fzf retains it.
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-ctrl-r" ];
    settings = {
      auto_sync = false; # Local-only history by default; turn on if desired.
      search_mode = "fuzzy";
      style = "compact";
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash.enable = false; # zsh is the only interactive shell.
}
