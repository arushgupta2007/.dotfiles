{
  inputs,
  username,
  ...
}:

{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;

  imports = [
    ./core
    ./wayland
  ];
}
