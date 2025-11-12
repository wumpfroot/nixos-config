{
  description = "A very basic flake with Musnix support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    musnix.url  = "github:musnix/musnix";
  };

  outputs = { self, nixpkgs, musnix, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ musnix.overlay ];
    };
  in
  rec {
    packages.${system} = {
      hello = pkgs.hello;
      default = pkgs.hello;
    };

    nixosConfigurations = {
      wumnix = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          musnix.nixosModules.musnix
          ./configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };





}
