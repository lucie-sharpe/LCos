{ config, pkgs, host, ... }: 

let
  inherit (import ../../../hosts/${host}/variables.nix) timeZone defaultLocale consoleKeyMap;
in
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  services.automatic-timezoned.enable = true;
  # time.timeZone = "${timeZone}";

  i18n.defaultLocale = "${defaultLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${defaultLocale}";
    LC_IDENTIFICATION = "${defaultLocale}";
    LC_MEASUREMENT = "${defaultLocale}";
    LC_MONETARY = "${defaultLocale}";
    LC_NAME = "${defaultLocale}";
    LC_NUMERIC = "${defaultLocale}";
    LC_PAPER = "${defaultLocale}";
    LC_TELEPHONE = "${defaultLocale}";
    LC_TIME = "${defaultLocale}";
  };
  console.keyMap = "${consoleKeyMap}";

  zramSwap = {
    enable = true;
    algorithm = "lzo";
    memoryPercent = 30;
  };

  hardware.graphics = {
    enable = true;
  };

  system.stateVersion = "24.11";
}