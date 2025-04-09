{ ... }: 

{
  imports = [
    ../../modules/nixos/core
    ../../modules/nixos/users.nix
  ];

  user_lucie.enable = true;
}