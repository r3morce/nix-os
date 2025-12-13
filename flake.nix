{
  description = "NixOS configuration with flakes - Dual-boot with CachyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/default.nix
          ./hosts/desktop/hardware-configuration.nix
        ];
      };
    };
  };
}
