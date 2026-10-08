{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    # C / C++
    gcc
    gnumake
  ];
}


