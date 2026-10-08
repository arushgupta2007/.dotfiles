{ pkgs, ... }:
{
  programs.superfile = {
    enable = true;
    pinnedFolders = [
      { name = "Desktop"; location = "/home/arush/Desktop"; }
      { name = "Downloads"; location = "/home/arush/Downloads"; }
      { name = "Projects"; location = "/home/arush/Projects"; }
    ];
  };
}

