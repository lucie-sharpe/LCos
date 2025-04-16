{ ... }: 

{
  imports = [
    ../../modules/nixos/core
    ../../modules/nixos/programs
    ../../modules/nixos/users.nix
  ];

  user_lucie.enable = true;
}