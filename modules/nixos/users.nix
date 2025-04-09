{ config, lib, pkgs, ... }:

{
  options = {
    user_lucie.enable = lib.mkEnableOption "Enable lucie user";
  };

  config = lib.mkIf config.user_lucie.enable {
    users.users."lucie" = {
      isNormalUser = true;
      description = "Lucie";
      extraGroups = [ "wheel" "networkmanager" ];
      initialPassword = "changeme";

      packages = with pkgs; [];
    };
  };
}