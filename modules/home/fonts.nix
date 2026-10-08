{ pkgs, config, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    twemoji-color-font
    noto-fonts-color-emoji
    google-fonts
    # monolisa
    # monolisa-nerd
  ];
}


