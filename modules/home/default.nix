{inputs, username, host, ...}: {
  imports =
       [(import ./aseprite/aseprite.nix)]         # pixel art editor
    ++ [(import ./ai.nix)]                 
    ++ [(import ./agenix.nix)]                 
    ++ [(import ./audacious.nix)]                 # music player
    ++ [(import ./bat.nix)]                       # better cat command
    ++ [(import ./brave.nix)]                     # Brave the browser
    ++ [(import ./btop.nix)]                      # resouces monitor 
    ++ [(import ./cava.nix)]                      # audio visualizer
    ++ [(import ./direnv.nix)]                    # Direnv
    ++ [(import ./discord/discord.nix)]                   # discord with catppuccin theme
    ++ [(import ./fastfetch.nix)]                       # fetch tool
    ++ [(import ./floorp/floorp.nix)]             # firefox based browser
    ++ [(import ./fonts.nix)]             # firefox based browser
    ++ [(import ./fzf.nix)]                       # fuzzy finder
    ++ [(import ./gaming.nix)]                    # packages related to gaming
    ++ [(import ./git.nix)]                       # version control
    ++ [(import ./gnome.nix)]                       # gnome apps
    ++ [(import ./gtk.nix)]                       # gtk theme
    # ++ [(import ./hyprland)]                      # window manager
    ++ [(import ./niri)]                      # window manager
    ++ [(import ./kanshi.nix)]                     # terminal
    ++ [(import ./kitty.nix)]                     # terminal
    ++ [(import ./kde-connect.nix)]               
    ++ [(import ./latex.nix)]                     # LaTex
    ++ [(import ./swaync/swaync.nix)]             # notification deamon
    ++ [(import ./micro.nix)]                     # nano replacement
    ++ [(import ./nvchad/nvchad.nix)]                      # neovim editor
    ++ [(import ./packages.nix)]                  # other packages
    ++ [(import ./qt.nix)]                  
    ++ [(import ./rclone.nix)]                      # launcher
    ++ [(import ./rofi.nix)]                      # launcher
    ++ [(import ./sagemath.nix)]
    ++ [(import ./superfile.nix)]
    ++ [(import ./scripts/scripts.nix)]           # personal scripts
    ++ [(import ./spicetify.nix)]                 # spotify client
    ++ [(import ./starship.nix)]                  # shell prompt
    ++ [(import ./swaylock.nix)]                  # lock screen
    ++ [(import ./vscodium.nix)]                  # vscode forck
    ++ [(import ./waybar)]                        # status bar
    ++ [(import ./dms)]                        # status bar
    ++ [(import ./xdg-mimes.nix)]                 # xdg config
    ++ [(import ./zsh.nix)];                      # shell
}
