{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # System
    curl
    git
    htop
    wget
    libnotify
    # xdg-user-dirs
    # xdg-utils
    
    # Hyprland
    kitty
    waybar
    rofi-wayland
    swaynotificationcenter
    swww

    # Apps
    firefox
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };
}