{ pkgs, ... }:

{
  programs = {
    git.enable = true;
    nm-applet.enable = true;
    nm-applet.indicator = true;
    mtr.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    curl
    htop
    wget
    libnotify
    eza
    xdg-user-dirs
    xdg-utils
  ];
}