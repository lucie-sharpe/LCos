{
  description = "Lucie OS - NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
  in
  {
    nixosConfigurations = {
      "laptop" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs;
          host = "laptop";
        };

        modules = [
          ./hosts/laptop/configuration.nix
        ];
      };
    };
  };
}