{ ... }: 

{
  imports = [
    ./system.nix
    ./boot.nix
    ./network.nix
    ./security.nix
  ];
}
