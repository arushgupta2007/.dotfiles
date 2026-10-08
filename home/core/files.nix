{ pkgs, ... }:

{
  # Nautilus as the graphical file manager.
  home.packages = with pkgs; [
    nautilus
    yazi
    papers
    loupe
    mpv
    file-roller
    btrfs-progs
  ];

  # Configure Nautilus to remember settings via dconf.
  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      sort-directories-first = true;
      show-hidden-files = false;
      click-policy = "single";
    };
  };
}
