{ pkgs, ... }:

{
  programs = {
    firefox.enable = true;

    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
  };

  environment.systemPackages = with pkgs; [];
}